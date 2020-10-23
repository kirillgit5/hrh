//
//  MapLocation.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import MapKit

struct LocationMap {
    let lat: CLLocationDegrees
    let lng: CLLocationDegrees
    
    init(lat: Double, lng: Double) {
        self.lat = CLLocationDegrees(exactly: lat) ?? 0.0
        self.lng = CLLocationDegrees(exactly: lng) ?? 0.0
    }
}
