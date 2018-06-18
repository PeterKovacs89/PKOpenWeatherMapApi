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
    
     /** Invalid base url */
    case invalidURL
    
     /** The expected response object could not been parsed from the received json data */
    case invalidResponseDataStructure
    
    /** Business logic error from the server */
    case businessError(code:Int, message:String)
}

/**
 Default implementation of PKNetworkManagerProtocol. Its' main role is communicating with the data servers
 */
class PKNetworkManager: PKNetworkManagerProtocol {
    
    private enum ObjectKeys: String {
        case code = "cod"
        case message
    }
    
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
                guard let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    completion?(nil, PKNetworkError.invalidResponseDataStructure)
                    return
                }
                
                let businessError = self.checkErrorCode(in: jsonResponse)
                
                guard businessError == nil else {
                    completion?(nil, businessError)
                    return
                }
                
                do {
                    let jsonModel = try T(with: jsonResponse)
                    completion?(jsonModel, nil)
                } catch PKSerializationError.missing( let key, let inModel) {
                    print("Missing \(key) key in \(inModel)")
                    completion?(nil, error)
                } catch let parserError {
                    completion?(nil, parserError)
                }
            } catch let serializationError {
                completion?(nil, serializationError)
                return
            }
            
        }.resume()
    }
    
    fileprivate func checkErrorCode(in response:[String: Any]) -> Error? {
        
        let error:Error?
        
        let responseCode: Int?
        
        if let value = response[ObjectKeys.code.rawValue] {
            
            if let intValue = value as? Int {
                responseCode = intValue
            } else if let stringValue = value as? String {
                responseCode = Int(stringValue)
            } else {
                responseCode = nil
            }
        } else {
            responseCode = nil
        }
        
        if let code = responseCode {
            
            if (code == 200) {
                error = nil
            } else {
                error = PKNetworkError.businessError(code: code, message: (response[ObjectKeys.message.rawValue] as? String) ?? "Missing message")
            }
        } else {
            //Response code is also optional...
            error = nil
        }
        
        return error
    }
}
