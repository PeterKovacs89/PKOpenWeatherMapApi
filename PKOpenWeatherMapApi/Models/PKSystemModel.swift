//
//  PKSystemModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 12..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKSystemModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case type
        case systemId = "id"
        case message
        case country
        case sunrise
        case sunset
    }
    
    private let systemType: Int?
    private let systemId: Int?
    private let systemMessage: Double?
    public let country: String
    public let sunrise: TimeInterval?
    public let sunset: TimeInterval?
    
    required init(with json:[String : Any]?) throws {
        
        guard let country = json?[ObjectKeys.country.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.country.rawValue, PKSystemModel.self)
        }
        
        self.country = country
        self.sunrise = json?[ObjectKeys.sunrise.rawValue] as? TimeInterval
        self.sunset = json?[ObjectKeys.sunset.rawValue] as? TimeInterval
        
        self.systemId = json?[ObjectKeys.systemId.rawValue] as? Int
        self.systemType = json?[ObjectKeys.type.rawValue] as? Int
        self.systemMessage = json?[ObjectKeys.message.rawValue] as? Double
    }
}
