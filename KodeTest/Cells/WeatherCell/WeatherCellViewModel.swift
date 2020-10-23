//
//  WeatherCellViewModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 17.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

protocol WeatherCellViewModelProtocol {
    init(weather: Weather)
    func getImageName() -> String
    func getTime() -> String
    func getDescription() -> String
}

class WeatherCellViewModel: WeatherCellViewModelProtocol {
    
    private let weather: Weather
    required init(weather: Weather) {
        self.weather = weather
    }
    
    func getImageName() -> String {
        return weather.main ?? "default"
    }
    
    func getTime() -> String {
        let hours = weather.date.getTimeInHours()
        if hours == nil {
            return "--"
        } else {
            return "\(hours!):00"
        }
    }
    
    func getDescription() -> String {
        let description = weather.main ?? "Неизвестно"
        guard let russianDescription = WeatherDescription.init(rawValue: description) else { return "Неизвестно" }
        return "\(russianDescription)"
        
    }
    
    
}


