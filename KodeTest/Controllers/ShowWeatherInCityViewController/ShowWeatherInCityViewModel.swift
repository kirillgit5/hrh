//
//  ShowWeatherInCityViewModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import MapKit


protocol ShowWeatherInCityViewModelProtocol {
    init(cityCoordinates: CityCoordinates)
    func getCityName() -> String
    func getLocation() -> LocationMap
    func getCurrentDateForShow() -> String
    func getTomorrowDateForShow() -> String
    func reloadData(complition: @escaping () -> ())
    func createViewModelFor(indexPath: IndexPath, type: ShowWeatherInCityViewModel.WeatherCollectionType) -> WeatherCellViewModelProtocol
    func getCountItem(type: ShowWeatherInCityViewModel.WeatherCollectionType) -> Int
    func isAttractiveButtonHidden() -> Bool
    func getViewModelForAttrectiveVC() -> AttractionsListViewModelProtocol
    
}

class ShowWeatherInCityViewModel: ShowWeatherInCityViewModelProtocol {
    
    private let cityCoordinates: CityCoordinates
    private let city: City?
    private var currentWeather: [Weather] = []
    private var tomorrowWeather: [Weather] = []
    
    private let dataFetcher = NetworkDataFetcher()
    private let dateManager = DateManager()
    private let storageManager = StorageManager.shared
    
    private var textRequest: String {
        "lat=\(cityCoordinates.lat)&lon=\(cityCoordinates.lng)"
    }
    
    enum WeatherCollectionType {
        case current
        case tomorrow
    }
    
    required init(cityCoordinates: CityCoordinates) {
        self.cityCoordinates = cityCoordinates
        city = storageManager.getCityForID(id: cityCoordinates.id)
        
    }
    
    func getCityName() -> String {
        cityCoordinates.name
    }
    
    func getLocation() -> LocationMap {
        LocationMap(lat: cityCoordinates.lat, lng: cityCoordinates.lng)
    }
    
    func getCurrentDateForShow() -> String {
        "Сегодня, " + Date().formatDateToStringDetailHeader()
    }
    
    func getTomorrowDateForShow() -> String {
        "Завтра, " + Date.tomorrow.formatDateToStringDetailHeader()
    }
    
    func reloadData(complition: @escaping () -> ()) {
        dataFetcher.getData(text: textRequest, searchType: NetworkService.SearchType.weather, decodeType: HourlyWeather.self) {[unowned self] (weather) in
            guard let weathers = weather else { return }
            let weatherModels = weathers.hourly.map { Weather(date: Date(timeIntervalSince1970: $0.date), main: $0.weather.first?.main, description:  $0.weather.first?.description) }
            self.currentWeather = self.dateManager.sortWeathersByCurrentDay(weathers: weatherModels)
            
            self.tomorrowWeather = self.dateManager.sortWeathersByTomorrowDay(weathers: weatherModels)
            complition()
        }
    }
    
    func createViewModelFor(indexPath: IndexPath, type: ShowWeatherInCityViewModel.WeatherCollectionType) -> WeatherCellViewModelProtocol {
        switch type {
        case .current:
            return WeatherCellViewModel(weather: currentWeather[indexPath.item])
        case .tomorrow:
            return WeatherCellViewModel(weather: tomorrowWeather[indexPath.item])
        }
    }
    
    func getCountItem(type: WeatherCollectionType) -> Int {
        switch type {
        case .current:
            return currentWeather.count
        case .tomorrow:
            return tomorrowWeather.count
        }
    }
    
    func isAttractiveButtonHidden() -> Bool {
        city == nil
    }
    
    func getViewModelForAttrectiveVC() -> AttractionsListViewModelProtocol {
        AttractionsListViewModel(city: city!)
    }
}



