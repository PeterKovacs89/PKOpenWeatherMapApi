//
//  PKNetworkManager.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

/**
 Errors what can be thrown by the network manager
 */
enum PKNetworkError: Error {
    
    case invalidURL /** Invalid base url */
    case invalidResponseDataStructure /** The expected response object could not been parsed from the received json data */
}

/**
 Default implementation of PKNetworkManagerProtocol. Its' main role is communicating with the data servers
 */
class PKNetworkManager: PKNetworkManagerProtocol {
    
    /**
     Singleton accessor
     */
    static let shared:PKNetworkManager = PKNetworkManager()
    
    /**
     Session for the network communication
     */
    private lazy var networkSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration)
    }()

    /**
     Send a GET request to the given URL string with the given parameters. If the request is successfull, a generic T object will be initialized with the result data. If not, then an error will be returned.
     @param urlString: the base URL of the request
     @param parameters: query parameters of the request
     @param completion: completion block of the request
     */
    func getRequest<T>(urlString: String, parameters: [String : String]?, completion: PKNetworkResponse<T>?) {
        
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
        
        guard let requestUrl = urlComponents.url else {
            completion?(nil, PKNetworkError.invalidURL)
            return
        }
        
        self.networkSession.dataTask(with: requestUrl) { (data, response, error) in
            
            guard let data = data else {
                completion?(nil, error)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                if let jsonModel = T(with: jsonResponse) {
                    completion?(jsonModel, nil)
                } else {
                    completion?(nil, PKNetworkError.invalidResponseDataStructure)
                }
            } catch let error {
                completion?(nil, error)
                return
            }
            
        }.resume()
    }
}
