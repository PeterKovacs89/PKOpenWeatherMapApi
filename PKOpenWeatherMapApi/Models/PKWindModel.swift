//
//  PKWindModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 12..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKWindModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case speed
        case degree = "deg"
        case gust
    }
    
    public let speed: Double
    public let degree: Int
    public let gust: Int
    
    required init(with json:[String : Any]?) throws {
        
        guard let speed = json?[ObjectKeys.speed.rawValue] as? Double else {
            throw PKSerializationError.missing(ObjectKeys.speed.rawValue, PKWindModel.self)
        }

        guard let degree = json?[ObjectKeys.degree.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.degree.rawValue, PKWindModel.self)
        }
        
        self.speed = speed
        self.degree = degree
        self.gust = (json?[ObjectKeys.gust.rawValue] as? Int ?? 0)
    }
}
