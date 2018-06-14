//
//  PKMultipleCitiesWeatherModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKCityWeatherListModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case cityList = "list"
        case elementCount = "cnt"
        case cod
    }
    
    private let cod: Int?
    private let elementCount: Int
    
    public let cityWeatherList: [PKCityWeatherModel]
    
    required init(with json:[String : Any]?) throws {
        
        guard let elementCount = json?[ObjectKeys.elementCount.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.elementCount.rawValue, PKCityWeatherListModel.self)
        }
        
        guard let cityList = json?[ObjectKeys.cityList.rawValue] as? [[String:Any]] else {
            throw PKSerializationError.missing(ObjectKeys.cityList.rawValue, PKCityWeatherListModel.self)
        }
        
        var cityWeatherList = [PKCityWeatherModel]()
        
        for cityData in cityList {
            let city = try PKCityWeatherModel(with: cityData)
            cityWeatherList.append(city)
        }
        
        self.cityWeatherList = cityWeatherList
        self.elementCount = elementCount
        self.cod = json?[ObjectKeys.cod.rawValue] as? Int
    }
}
