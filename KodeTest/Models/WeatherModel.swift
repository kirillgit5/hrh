//
//  WeatherModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation


struct HourlyWeather: Decodable {
    let hourly: [Hourly]
}

struct Hourly: Decodable {
    let date: TimeInterval
    let weather: [WeatherDecode]
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case weather
    }
}

struct WeatherDecode: Decodable{
    let main: String
    let description: String
}

struct Weather {
    let date: Date
    let main: String?
    let description: String?
}
