//
//  CityCoordinates.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct ResultCoordinate: Codable  {
    let result: CityCoordinatesForDecode
}

struct CityCoordinatesForDecode: Codable {
    let geometry: Geometry
    let name: String
}

struct Geometry: Codable {
    let location: Location
}

struct Location: Codable {
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
           case lon = "lng"
           case lat
       }
}

struct CityCoordinates {
    let name: String
    let lat: Double
    let lng: Double
    let id: String
}





