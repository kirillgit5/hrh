//
//  Extension + Date.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 17.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

extension Date {
func formatDateToStringDetailHeader() -> String {
     let calendar = Calendar.current
     
     let yearComponets = calendar.dateComponents([.year], from: self)
     let mounthComponets = calendar.dateComponents([.month], from: self)
     let dayComponets = calendar.dateComponents([.day], from: self)
     
     guard let year = yearComponets.year ,
         let day = dayComponets.day,
         let mount = mounthComponets.month,
         let mounthTextRus = NumberedMonthsRus(rawValue: mount) else { return  ""}
    
     return "\(day) \(mounthTextRus) \(year)"
 }
}

extension Date {
    static var tomorrow:  Date { return Date().dayAfter }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
   
}


extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
    
    func getTimeInHours() -> Int? {
        let calendar = Calendar.current
        let dateComponent = calendar.dateComponents([.hour], from: self)
        return dateComponent.hour
    }
    
}
