//
//  JSONInitializable.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 08..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

enum PKSerializationError: Error {
    case missing(String, PKJSONInitializable.Type)
}

protocol PKJSONInitializable {
    init(with json:[String:Any]?) throws
}
