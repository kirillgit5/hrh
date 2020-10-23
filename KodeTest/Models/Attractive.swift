//
//  Attractive.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct Attractive: Decodable {
    let name: String
    let preview: Preview
    let point: LocationAttractive
    let info: Info
    
    enum CodingKeys: String, CodingKey {
        case info = "wikipedia_extracts"
        case name
        case preview
        case point
    }
    
}


struct Preview: Decodable {
    let source: String
}


struct LocationAttractive: Decodable {
    let lat: Double
    let lon: Double
    
}

struct Info: Decodable {
    let text: String
}





