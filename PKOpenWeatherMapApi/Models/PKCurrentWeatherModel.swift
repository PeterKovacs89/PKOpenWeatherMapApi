//
//  PKCurrentWeatherModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

class PKCurrentWeatherModel: PKJSONInitializable {
    
    private enum ObjectKeys: String {
        case coordinate = "coord"
        case weatherUI = "weather"
        case weatherData = "main"
        case wind
        case clouds
        case system = "sys"
        case rain
        case snow
        case timestamp = "dt"
        case cityId = "id"
        case cityName = "name"
        case cod
        case base
    }
    
    private let base: String?
    private let cod: Int?
    
    let coordinate: PKCoordinateModel
    let weatherUI: PKWeatherUIModel
    let weatherData: PKWeatherDataModel
    let wind: PKWindModel
    let clouds: PKCloudModel
    let timestamp: TimeInterval
    let systemData: PKSystemModel
    let cityId: Int
    let cityName: String
    
    let snow: PKSnowModel?
    let rain: PKRainModel?
    
    required init(with json:[String : Any]?) throws {
        
        guard let timestamp = json?[ObjectKeys.timestamp.rawValue] as? TimeInterval else {
            throw PKSerializationError.missing(ObjectKeys.timestamp.rawValue, PKCurrentWeatherModel.self)
        }
        
        guard let cityId = json?[ObjectKeys.cityId.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.cityId.rawValue, PKCurrentWeatherModel.self)
        }
        
        guard let cityName = json?[ObjectKeys.cityName.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.cityName.rawValue, PKCurrentWeatherModel.self)
        }
        
        let coordinate = try PKCoordinateModel(with: json?[ObjectKeys.coordinate.rawValue] as? [String:Any])
        let weatherUI = try PKWeatherUIModel(with: json?[ObjectKeys.weatherUI.rawValue] as? [String:Any])
        let weatherData = try PKWeatherDataModel(with: json?[ObjectKeys.weatherData.rawValue] as? [String:Any])
        let wind = try PKWindModel(with: json?[ObjectKeys.wind.rawValue] as? [String:Any])
        let clouds = try PKCloudModel(with: json?[ObjectKeys.clouds.rawValue] as? [String:Any])
        let systemData = try PKSystemModel(with: json?[ObjectKeys.system.rawValue] as? [String:Any])
        let snow = try PKSnowModel(with: json?[ObjectKeys.snow.rawValue] as? [String:Any])
        let rain = try PKRainModel(with: json?[ObjectKeys.rain.rawValue] as? [String:Any])
        
        self.timestamp = timestamp
        self.cityId = cityId
        self.cityName = cityName
        self.coordinate = coordinate
        self.weatherUI = weatherUI
        self.weatherData = weatherData
        self.wind = wind
        self.clouds = clouds
        self.systemData = systemData
        self.snow = snow
        self.rain = rain
        
        self.base = json?[ObjectKeys.cityId.rawValue] as? String
        self.cod = json?[ObjectKeys.cityId.rawValue] as? Int
    }
}
