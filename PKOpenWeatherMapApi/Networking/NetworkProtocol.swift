//
//  NetworkProtocol.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import Foundation

/**
 Generic completion block for network calls
 */
typealias NetworkResponse<T:JSONModel> = ((T?, Error?)->())

/**
 Networking protocol, which has to be implemented by the networking modules
 */
protocol NetworkManagerProtocol {
    /**
     Send a GET request to the given URL string with the given parameters. If the request is successfull, a generic T object will be initialized with the result data. If not, then an error will be returned.
     @param urlString: the base URL of the request
     @param parameters: query parameters of the request
     @param completion: completion block of the request
     */
    func getRequest<T:JSONModel>(urlString:String, parameters:[String:String]?, completion:NetworkResponse<T>?)
}

/**
 Dependency injection protocol for network managers
 */
protocol NetworkManagerAssembler {
    func resolve() -> NetworkManagerProtocol
}


