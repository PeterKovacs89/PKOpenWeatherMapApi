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
        case today
    }
    
    public let cloudiness: Int
    
    required init(with json:[String : Any]?) throws {
        
        if let cloudiness = json?[ObjectKeys.all.rawValue] as? Int {
            self.cloudiness = cloudiness
        } else if let cloudiness = json?[ObjectKeys.today.rawValue] as? Int {
            self.cloudiness = cloudiness
        } else {
            throw PKSerializationError.missing(ObjectKeys.all.rawValue, PKCloudModel.self)
        }
    }
}
