
//
//  PKCoordinateModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 12..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import Foundation
import CoreLocation


public class PKCoordinateModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    public let coordinate: CLLocationCoordinate2D
    
    required init(with json:[String : Any]?) throws {
        
        guard let latitude = json?[ObjectKeys.latitude.rawValue] as? CLLocationDegrees else {
            throw PKSerializationError.missing(ObjectKeys.latitude.rawValue, PKCoordinateModel.self)
        }
        
        guard let longitude = json?[ObjectKeys.longitude.rawValue] as? CLLocationDegrees else {
            throw PKSerializationError.missing(ObjectKeys.longitude.rawValue, PKCoordinateModel.self)
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
