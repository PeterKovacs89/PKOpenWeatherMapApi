//
//  PKCurrentWeatherModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKCityWeatherModel: PKJSONInitializable {
    
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
    
    public let coordinate: PKCoordinateModel
    public let weatherUI: PKWeatherUIModel
    public let weatherData: PKWeatherDataModel
    public let wind: PKWindModel
    public let clouds: PKCloudModel
    public let timestamp: TimeInterval
    public let systemData: PKSystemModel
    public let cityId: Int
    public let cityName: String
    
    public let snow: PKSnowModel?
    public let rain: PKRainModel?
    
    required init(with json:[String : Any]?) throws {
        
        guard let timestamp = json?[ObjectKeys.timestamp.rawValue] as? TimeInterval else {
            throw PKSerializationError.missing(ObjectKeys.timestamp.rawValue, PKCityWeatherModel.self)
        }
        
        guard let cityId = json?[ObjectKeys.cityId.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.cityId.rawValue, PKCityWeatherModel.self)
        }
        
        guard let cityName = json?[ObjectKeys.cityName.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.cityName.rawValue, PKCityWeatherModel.self)
        }
        
        let coordinate = try PKCoordinateModel(with: json?[ObjectKeys.coordinate.rawValue] as? [String:Any])
        let weatherUI = try PKWeatherUIModel(with: (json?[ObjectKeys.weatherUI.rawValue] as? [[String:Any]])?.first)
        let weatherData = try PKWeatherDataModel(with: json?[ObjectKeys.weatherData.rawValue] as? [String:Any])
        let wind = try PKWindModel(with: json?[ObjectKeys.wind.rawValue] as? [String:Any])
        let clouds = try PKCloudModel(with: json?[ObjectKeys.clouds.rawValue] as? [String:Any])
        let systemData = try PKSystemModel(with: json?[ObjectKeys.system.rawValue] as? [String:Any])
        
        if let snowData = json?[ObjectKeys.snow.rawValue] as? [String:Any] {
            let snow = try PKSnowModel(with: snowData)
            self.snow = snow
        } else {
            self.snow = nil
        }
        
        if let rainData = json?[ObjectKeys.rain.rawValue] as? [String:Any] {
            let rain = try PKRainModel(with: rainData)
            self.rain = rain
        } else {
            self.rain = nil
        }
        
        self.timestamp = timestamp
        self.cityId = cityId
        self.cityName = cityName
        self.coordinate = coordinate
        self.weatherUI = weatherUI
        self.weatherData = weatherData
        self.wind = wind
        self.clouds = clouds
        self.systemData = systemData
        
        self.base = json?[ObjectKeys.base.rawValue] as? String
        self.cod = json?[ObjectKeys.cod.rawValue] as? Int
    }
}
