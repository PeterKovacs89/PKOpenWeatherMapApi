//
//  PKWeatherManager.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import Foundation
import CoreLocation

public enum UnitType: String {

    case imperial   /** Temperatures will be shown in Fahrenheit, speeds in miles/hour */
    case metric     /** Temperatures will be shown in Celsius, speeds in meter/sec */
    case standard   /** Temperatures will be shown in Kelvin, speeds in meter/sec */
    
    var queryParameterValue: String? {
        
        switch self {
        case .imperial, .metric: return self.rawValue
        case .standard: return nil
        }
    }
}

fileprivate enum PKWeatherAPIEndPoint: String {
    
    case currentWeather = "weather"
    case boundingBoxSearch = "box/city"
    case circularSearch = "find"
    case cityIds = "group"
}

fileprivate enum PKQueryParameter: String {
    case query = "q"
    case units
    case apiKey = "appid"
    case latitude = "lat"
    case longitude = "lon"
    case zipCode = "zip"
    case boundingBox = "bbox"
    case count = "cnt"
    case cityId = "id"
}

public class PKWeatherManager {

    fileprivate struct ServerConfiguration {
        static let baseUrl = "http://api.openweathermap.org/data"
        static let apiVersion = "2.5"
        
        static var serverUrl: String {
            return "\(ServerConfiguration.baseUrl)/\(ServerConfiguration.apiVersion)/"
        }
        
        static func forgeUrlString(with apiEndPoint:PKWeatherAPIEndPoint) -> String {
            let endPoint = apiEndPoint.rawValue
            return "\(ServerConfiguration.serverUrl)/\(endPoint)"
        }
    }
    
    private let assembler = PKLiveAssembler()
    
    private lazy var networkManager: PKNetworkManagerProtocol = {
        return self.assembler.resolve()
    }()
    
    private var apiKey: String
    public var preferredUnits: UnitType
    
    public init(with apiKey:String, preferredUnits:UnitType = .standard) {
        self.apiKey = apiKey
        self.preferredUnits = preferredUnits
    }
    
    fileprivate func generalRequest<T:PKJSONInitializable>(with endPoint:PKWeatherAPIEndPoint, params:[PKQueryParameter:String], completionBlock:@escaping PKNetworkResponse<T>) {
        
        let baseUrl = ServerConfiguration.forgeUrlString(with: endPoint)
        
        var query = params
        query[.units] = self.preferredUnits.rawValue
        query[.apiKey] = self.apiKey
        
        var parameters = [String: String]()
        query.forEach({ parameters[$0.key.rawValue] = $0.value })
        
        self.networkManager.getRequest(urlString: baseUrl, parameters: parameters, completion: completionBlock)
    }
}

//MARK: - Current Weather Data
public extension PKWeatherManager {
    
    public typealias PKCityWeatherCompletionBlock = ((PKCityWeatherModel?, Error?)->())
    public typealias PKCityWeatherListCompletionBlock = ((PKCityWeatherListModel?, Error?)->())
    
    /** Current weather by name of the city and country code */
    public func requestCurrentWeather(cityName:String, countryCode:String? = nil, completion:@escaping PKCityWeatherCompletionBlock) {
     
        var queryString = cityName
        
        if let countryCode = countryCode {
            queryString.append(",\(countryCode)")
        }
        
        var parameters = [PKQueryParameter: String]()
        parameters[.query] = queryString
        
        self.generalRequest(with: .currentWeather, params: parameters, completionBlock: completion)
    }
    
    /** Current weather by zip code of the city and country code */
    public func requestCurrentWeather(zipCode:String, countryCode:String? = nil, completion:@escaping PKCityWeatherCompletionBlock) {
        
        var queryString = zipCode
        
        if let countryCode = countryCode {
            queryString.append(",\(countryCode)")
        }
        
        var parameters = [PKQueryParameter: String]()
        parameters[.zipCode] = queryString
        
        self.generalRequest(with: .currentWeather, params: parameters, completionBlock: completion)
    }
    
    /** Current weather by coordinate of the city */
    public func requestCurrentWeather(coordinate:CLLocationCoordinate2D, completion:@escaping PKCityWeatherCompletionBlock) {
        
        var parameters = [PKQueryParameter: String]()
        parameters[.latitude] = String(coordinate.latitude)
        parameters[.longitude] = String(coordinate.longitude)
        
        self.generalRequest(with: .currentWeather, params: parameters, completionBlock: completion)
    }
    
    /** Current weather by a geographic rectangle */
    public func requestCurrentWeather(bottomLeftCoordinate:CLLocationCoordinate2D, topRightCoordinate:CLLocationCoordinate2D, zoomLevel:Int, completion:@escaping PKCityWeatherListCompletionBlock) {
        
        var params = [String]()
        params.append(String(bottomLeftCoordinate.longitude))
        params.append(String(bottomLeftCoordinate.latitude))
        params.append(String(topRightCoordinate.longitude))
        params.append(String(topRightCoordinate.latitude))
        params.append(String(zoomLevel))
        
        var parameters = [PKQueryParameter: String]()
        parameters[.boundingBox] = params.joined(separator: ",")
        
        self.generalRequest(with: .boundingBoxSearch, params: parameters, completionBlock: completion)
    }
    
    /** Current weather around a geo point, returns weather of cityCount cities */
    public func requestCurrentWeather(coordinate:CLLocationCoordinate2D, cityCount:Int = 10, completion:@escaping PKCityWeatherListCompletionBlock) {
        
        var parameters = [PKQueryParameter: String]()
        parameters[.latitude] = String(coordinate.latitude)
        parameters[.longitude] = String(coordinate.longitude)
        parameters[.count] = String(cityCount)
        
        self.generalRequest(with: .circularSearch, params: parameters, completionBlock: completion)
    }
    
    /** Current weather for list of cities, upper limit is 20 for one request */
    public func requestCurrentWeather(cityIds:[Int], completion:@escaping PKCityWeatherListCompletionBlock) {
        
        let cities: [String] = Array(cityIds[0 ..< 20]).map({String($0)})
        
        var parameters = [PKQueryParameter: String]()
        parameters[.cityId] = cities.joined(separator: ",")
        
        self.generalRequest(with: .circularSearch, params: parameters, completionBlock: completion)
    }
}
