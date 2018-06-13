//
//  PKWeatherManager.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

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
}

fileprivate enum PKQueryParameter: String {
    case query = "q"
    case units
    case apiKey = "appid"
    
}

public class PKWeatherManager {

    fileprivate struct ServerConfiguration {
        static let baseUrl = "api.openweathermap.org/data"
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
    
    public typealias PKCurrentWeatherCompletionBlock = ((PKCloudModel?, Error?)->())
    
    /** Weather request */
    public func requestCurrentWeather(with cityName:String, countryCode:String? = nil, completion:@escaping PKCurrentWeatherCompletionBlock) {
     
        var queryString = cityName
        
        if let countryCode = countryCode {
            queryString.append(",\(countryCode)")
        }
        
        var parameters = [PKQueryParameter: String]()
        parameters[.query] = cityName
        
        self.generalRequest(with: .currentWeather, params: parameters, completionBlock: completion)
    }
}
