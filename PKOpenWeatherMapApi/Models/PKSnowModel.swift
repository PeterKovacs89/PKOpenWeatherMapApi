//
//  PKSnowModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKSnowModel: PKJSONInitializable {
    
    private enum ObjectKeys: String {
        case volume = "3h"
    }
    
    public let volume: Double /** Volume in the last 3 hours */
    
    required init(with json:[String : Any]?) throws {
        
        guard let volume = json?[ObjectKeys.volume.rawValue] as? Double else {
            throw PKSerializationError.missing(ObjectKeys.volume.rawValue, PKSnowModel.self)
        }
        
        self.volume = volume
    }
}
