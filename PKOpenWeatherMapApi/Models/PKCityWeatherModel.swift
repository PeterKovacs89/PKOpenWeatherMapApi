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
        case base
    }
    
    private let base: String?
    
    public let weatherUI: PKWeatherUIModel
    public let weatherData: PKWeatherDataModel
    public let wind: PKWindModel
    public let clouds: PKCloudModel
    public let timestamp: TimeInterval
    public let systemData: PKSystemModel?
    public let city: PKCityModel
    
    public let snow: PKSnowModel?
    public let rain: PKRainModel?
    
    required init(with json:[String : Any]?) throws {
        
        guard let timestamp = json?[ObjectKeys.timestamp.rawValue] as? TimeInterval else {
            throw PKSerializationError.missing(ObjectKeys.timestamp.rawValue, PKCityWeatherModel.self)
        }
        
        let cityId = json?[ObjectKeys.cityId.rawValue] as? Int ?? 0
        let cityName = json?[ObjectKeys.cityName.rawValue] as? String ?? ""
        let coordinate = try PKCoordinateModel(with: json?[ObjectKeys.coordinate.rawValue] as? [String:Any])
        let weatherUI = try PKWeatherUIModel(with: (json?[ObjectKeys.weatherUI.rawValue] as? [[String:Any]])?.first)
        let weatherData = try PKWeatherDataModel(with: json?[ObjectKeys.weatherData.rawValue] as? [String:Any])
        let wind = try PKWindModel(with: json?[ObjectKeys.wind.rawValue] as? [String:Any])
        let clouds = try PKCloudModel(with: json?[ObjectKeys.clouds.rawValue] as? [String:Any])
        
        if let systemData = json?[ObjectKeys.system.rawValue] as? [String:Any] {
            let system = try PKSystemModel(with: systemData)
            self.systemData = system
        } else {
            self.systemData = nil
        }
        
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
        self.city = PKCityModel(cityId: cityId, name:cityName, country: nil, coordinate: coordinate)
        self.weatherUI = weatherUI
        self.weatherData = weatherData
        self.wind = wind
        self.clouds = clouds
        
        self.base = json?[ObjectKeys.base.rawValue] as? String
    }
}
