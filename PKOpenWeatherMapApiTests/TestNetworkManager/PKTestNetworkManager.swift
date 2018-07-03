//
//  PKTestNetworkManager.swift
//  PKOpenWeatherMapApiTests
//
//  Created by PeterKovacs on 2018. 07. 03..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

@testable import PKOpenWeatherMapApi

class PKTestNetworkManager: PKNetworkManagerProtocol {

    private enum TestUrl: String {
        case weatherWithCityNameAndCountryCode = "http://api.openweathermap.org/data/2.5/weather?appid=e2f86a4ff72f0ed3b28f38f4491f2ca0&units=standard&q=Szeged,hu"
        
        var responseData: String {
            
            switch self {
            case .weatherWithCityNameAndCountryCode:
                return "{\"coord\":{\"lon\":20.15,\"lat\":46.25},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01d\"}],\"base\":\"stations\",\"main\":{\"temp\":300.15,\"pressure\":1016,\"humidity\":36,\"temp_min\":300.15,\"temp_max\":300.15},\"visibility\":10000,\"wind\":{\"speed\":2.1,\"deg\":10},\"clouds\":{\"all\":0},\"dt\":1530623700,\"sys\":{\"type\":1,\"id\":5732,\"message\":0.0022,\"country\":\"HU\",\"sunrise\":1530586378,\"sunset\":1530642851},\"id\":715429,\"name\":\"Szeged\",\"cod\":200}"
            }
        }
    }
    
    func getRequest<T:PKJSONInitializable>(urlString:String, parameters:[String:String]?, completion:PKNetworkResponse<T>?) {
        
        guard var urlComponents = URLComponents(string: urlString) else {
            completion?(nil, PKNetworkError.invalidURL)
            return
        }
        
        var queryItems = [URLQueryItem]()
        
        if let parameters = parameters {
            for element in parameters {
                let item = URLQueryItem(name: element.key, value: element.value)
                queryItems.append(item)
            }
        }
        
        urlComponents.queryItems = queryItems
        
        guard let requestUrl = urlComponents.string else {
            completion?(nil, PKNetworkError.invalidURL)
            return
        }
        
        if let testData = TestUrl(rawValue: requestUrl)?.responseData.data(using: .utf8) {
        
            guard let jsonResponse = try? JSONSerialization.jsonObject(with: testData, options: []) as? [String: Any] else {
                completion?(nil, PKNetworkError.invalidResponseDataStructure)
                return
            }
            
            let jsonModel = try! T(with: jsonResponse)
            completion?(jsonModel, nil)
        } else {
            completion?(nil, PKNetworkError.invalidResponseDataStructure)
        }
    }
}
