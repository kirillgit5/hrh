//
//  DateManager.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 17.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class DateManager {
    
    func sortWeathersByCurrentDay(weathers: [Weather]) -> [Weather] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentDay = calendar.dateComponents([.day], from: currentDate)
        let currentDates = weathers.filter { (weather) -> Bool in
            let day = calendar.dateComponents([.day], from: weather.date)
            return day == currentDay
        }
        
        return currentDates
}
    
    func sortWeathersByTomorrowDay(weathers: [Weather]) -> [Weather] {
        let currentDate = Date.tomorrow
        let calendar = Calendar.current
        let currentDay = calendar.dateComponents([.day], from: currentDate)
        let currentDates = weathers.filter { (weather) -> Bool in
            let day = calendar.dateComponents([.day], from: weather.date)
            return day == currentDay
        }
        return currentDates
    }
}
