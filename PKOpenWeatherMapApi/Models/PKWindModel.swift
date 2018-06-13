//
//  PKWindModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 12..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

class PKWindModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case speed
        case degree = "deg"
    }
    
    var speed: Double
    var degree: Int
    
    required init?(with json:[String : Any]?) {
        
        guard let speed = json?[ObjectKeys.speed.rawValue] as? Double else { return nil }
        guard let degree = json?[ObjectKeys.degree.rawValue] as? Int else { return nil }
        
        self.speed = speed
        self.degree = degree
    }
}
