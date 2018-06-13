//
//  JSONInitializable.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

protocol PKJSONInitializable {
    init?(with json:[String:Any]?)
}

protocol PKResponseProtocol {
    var code: Int {get set}
}
