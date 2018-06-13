
//
//  PKCoordinateModel.swift
//  PKOpenWeatherMapApi
//
//  Created by PeterKovacs on 2018. 06. 12..
//  Copyright © 2018. PeterKovacs. All rights reserved.
//

import Foundation
import CoreLocation


class PKCoordinateModel: PKJSONInitializable {

    private enum ObjectKeys: String {
        case latitude = "lat"
        case longitude = "lon"
    }
    
    var coordinate: CLLocationCoordinate2D
    
    required init?(with json:[String : Any]?) {
        
        guard let latitude = json?[ObjectKeys.latitude.rawValue] as? CLLocationDegrees else { return nil }
        guard let longitude = json?[ObjectKeys.longitude.rawValue] as? CLLocationDegrees else { return nil }
        
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
