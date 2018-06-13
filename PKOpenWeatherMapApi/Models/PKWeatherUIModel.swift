//
//  PKWeatherUIModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

class PKWeatherUIModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case weatherId = "id"
        case main
        case description
        case icon
    }
    
    var weatherId: Int
    var mainParameter: String
    var description: String
    var iconId: String
    
    required init?(with json:[String : Any]?) {
        
        guard let weatherId = json?[ObjectKeys.weatherId.rawValue] as? Int else { return nil }
        guard let mainParameter = json?[ObjectKeys.main.rawValue] as? String else { return nil }
        guard let description = json?[ObjectKeys.description.rawValue] as? String else { return nil }
        guard let iconId = json?[ObjectKeys.icon.rawValue] as? String else { return nil }
        
        self.weatherId = weatherId
        self.mainParameter = mainParameter
        self.description = description
        self.iconId = iconId
    }
}
