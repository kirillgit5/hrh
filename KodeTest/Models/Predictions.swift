//
//  Models.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 15.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct  CityResponse: Decodable {
    let description: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
           case description
           case id = "place_id"
       }
}

struct Predictions: Decodable {
    let predictions: [CityResponse]
}

