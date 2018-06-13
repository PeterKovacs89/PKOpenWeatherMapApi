//
//  PKWeatherDataModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

class PKWeatherDataModel: NSObject {
    
    private enum ObjectKeys: String {
        case temperature = "temp"
        case humidity
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure
        case seaLevelPressure = "sea_level"
        case groundLevelPressure = "grnd_level"
    }
    
    var temperature: Double
    var humidity: Int
    var minTemperature: Double?
    var maxTemperature: Double?
    var pressure: Int?
    var seaLevelPressure: Int?
    var groundLevelPressure: Int?
    
    required init?(with json:[String : Any]?) {
        
        guard let temperature = json?[ObjectKeys.temperature.rawValue] as? Double else { return nil }
        guard let humidity = json?[ObjectKeys.humidity.rawValue] as? Int else { return nil }
        
        self.temperature = temperature
        self.humidity = humidity
        
        self.minTemperature = json?[ObjectKeys.minTemperature.rawValue] as? Double
        self.maxTemperature = json?[ObjectKeys.maxTemperature.rawValue] as? Double
        self.pressure = json?[ObjectKeys.pressure.rawValue] as? Int
        self.seaLevelPressure = json?[ObjectKeys.seaLevelPressure.rawValue] as? Int
        self.groundLevelPressure = json?[ObjectKeys.groundLevelPressure.rawValue] as? Int
    }
}
