//
//  PKSystemModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 12..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

class PKSystemModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case type
        case systemId = "id"
        case message
        case country
        case sunrise
        case sunset
    }
    
    private var systemType: Int?
    private var systemId: Int?
    private var systemMessage: Double?
    var country: String
    var sunrise: TimeInterval
    var sunset: TimeInterval
    
    required init(with json:[String : Any]?) throws {
        
        guard let country = json?[ObjectKeys.country.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.country.rawValue, PKSystemModel.self)
        }
        
        guard let sunrise = json?[ObjectKeys.sunrise.rawValue] as? TimeInterval else {
            throw PKSerializationError.missing(ObjectKeys.sunrise.rawValue, PKSystemModel.self)
        }
        
        guard let sunset = json?[ObjectKeys.sunset.rawValue] as? TimeInterval else {
            throw PKSerializationError.missing(ObjectKeys.sunset.rawValue, PKSystemModel.self)
        }
        
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
        
        self.systemId = json?[ObjectKeys.systemId.rawValue] as? Int
        self.systemType = json?[ObjectKeys.type.rawValue] as? Int
        self.systemMessage = json?[ObjectKeys.message.rawValue] as? Double
    }
}
