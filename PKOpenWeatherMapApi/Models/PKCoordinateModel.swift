
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
        case latitudeVersion2 = "Lat"
        case longitudeVersion2 = "Lon"
    }
    
    public let coordinate: CLLocationCoordinate2D
    
    required init(with json:[String : Any]?) throws {
        
        let latitude: CLLocationDegrees
        let longitude: CLLocationDegrees
        
        if let lat = json?[ObjectKeys.latitude.rawValue] as? CLLocationDegrees {
            latitude = lat
        } else if let lat = json?[ObjectKeys.latitudeVersion2.rawValue] as? CLLocationDegrees {
            latitude = lat
        } else {
            throw PKSerializationError.missing(ObjectKeys.latitude.rawValue, PKCoordinateModel.self)
        }
        
        if let lon = json?[ObjectKeys.longitude.rawValue] as? CLLocationDegrees {
            longitude = lon
        } else if let lon = json?[ObjectKeys.longitudeVersion2.rawValue] as? CLLocationDegrees {
            longitude = lon
        } else {
            throw PKSerializationError.missing(ObjectKeys.longitude.rawValue, PKCoordinateModel.self)
        }
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
