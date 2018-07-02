//
//  PKCityModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 18..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import UIKit

public class PKCityModel: PKJSONInitializable {
    
    private enum ObjectKeys: String {
        case cityId = "id"
        case name
        case coordinate = "cord"
        case country
    }
    
    public let cityId: Int
    public let name: String
    public let coordinate: PKCoordinateModel
    public let country: String?
    
    required init(with json:[String : Any]?) throws {
        
        guard let cityId = json?[ObjectKeys.cityId.rawValue] as? Int else {
            throw PKSerializationError.missing(ObjectKeys.cityId.rawValue, PKCityModel.self)
        }
        
        guard let name = json?[ObjectKeys.name.rawValue] as? String else {
            throw PKSerializationError.missing(ObjectKeys.name.rawValue, PKCityModel.self)
        }
        
        self.cityId = cityId
        self.name = name
        self.country = json?[ObjectKeys.country.rawValue] as? String
        
        self.coordinate = try PKCoordinateModel(with: json?[ObjectKeys.coordinate.rawValue] as? [String:Any])
    }
    
    init(cityId:Int, name:String, country:String?, coordinate:PKCoordinateModel) {
        self.cityId = cityId
        self.name = name
        self.coordinate = coordinate
        self.country = country
    }
}
