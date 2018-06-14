//
//  PKWeatherUIModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKWeatherUIModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case weatherId = "id"
        case main
        case description
        case icon
    }
    
    public let weatherId: Int
    public let mainParameter: String
    public let description: String
    public let iconId: String
    
    required init(with json:[String : Any]?) throws {
        
        guard let weatherId = json?[ObjectKeys.weatherId.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.weatherId.rawValue, PKWeatherUIModel.self)
        }
        
        guard let mainParameter = json?[ObjectKeys.main.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.main.rawValue, PKWeatherUIModel.self)
        }
        
        guard let description = json?[ObjectKeys.description.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.description.rawValue, PKWeatherUIModel.self)
        }
        
        guard let iconId = json?[ObjectKeys.icon.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.icon.rawValue, PKWeatherUIModel.self)
        }
        
        self.weatherId = weatherId
        self.mainParameter = mainParameter
        self.description = description
        self.iconId = iconId
    }
}
