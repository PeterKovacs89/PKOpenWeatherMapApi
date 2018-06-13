//
//  PKSnowModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 13..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

class PKSnowModel: NSObject {
    private enum ObjectKeys: String {
        case volume = "3h"
    }
    
    var volume: Double /** Volume in the last 3 hours */
    
    required init?(with json:[String : Any]?) {
        
        guard let volume = json?[ObjectKeys.volume.rawValue] as? Double else { return nil }
        
        self.volume = volume
    }
}
