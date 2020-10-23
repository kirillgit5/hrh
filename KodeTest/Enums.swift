//
//  Enums.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

enum SegueIdentifiers: String {
    case showWeatherInCity, showAttrections, showAttrection, showInMap, ShowDescription
}

enum NumberedMonthsRus : Int {
    case января = 1, февраля, марта, апреля, мая, июня, июля, августа, сентября, октября, ноября, декабря
}

enum WeekDays: Int {
    case  вс = 1, пон, вт, ср, чт, пят, суб
}

enum WeatherDescription: String {
    case Гроза = "Thunderstorm"
    case Морось = "Drizzle"
    case Дождь = "Rain"
    case Снег = "Snow"
    case Дымка =  "Mist"
    case Дым = "Smoke"
    case Мгла = "Haze"
    case Пыли = "Dust"
    case Туман = "Fog"
    case Песок = "Sand"
    case Ураган = "Squall"
    case Торнадо = "Tornado"
    case Ясно = "Clear"
    case Облачно = "Clouds"
    case Неизвестно = "Неизвестно"
}

