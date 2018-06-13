//
//  PKCloudModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKCloudModel: PKJSONInitializable {
    
    private enum ObjectKeys: String {
        case all
    }
    
    var cloudiness: Int
    
    required init(with json:[String : Any]?) throws {
        
        guard let cloudiness = json?[ObjectKeys.all.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.all.rawValue, PKCloudModel.self)
        }
        
        self.cloudiness = cloudiness
    }
}
