//
//  SearchViewModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 15.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import CoreData

protocol SearchViewModelProtocol {
    var titleForSection: Box<String> { get }
    func setTextForSearch(text: String?, complition: @escaping (() -> Void) )
    func getCityNameForCell(at indexPath: IndexPath) -> String
    func getCitiesCount() -> Int
    func lookCity(indexPath: IndexPath, complition: @escaping ((ShowWeatherInCityViewModelProtocol) -> Void))
    func isTableViewNeedReload(text: String,newText: String) -> Bool
    func reloadRecentlyRequest()
    
}

class SearchViewModel: SearchViewModelProtocol {
    
    //MARK: - Boxing Properties
    var titleForSection: Box<String> = Box(value: "Последние запросы")
    
    //MARK: - Services
    private let networkDataFetcher = NetworkDataFetcher()
    private let storageManager = StorageManager.shared
    private var cities: [CityResponse] = []
    private var recentRequests: [RecentRequest] = []
    private var isSearchBarEmpty = true
    private var isSearchCity = false
    
    func setTextForSearch(text: String?, complition: @escaping (() -> Void) ) {
        guard let text = text else { complition() ; return }
        
        networkDataFetcher.getData(text: text, searchType: NetworkService.SearchType.cities, decodeType: Predictions.self) { (decodable) in
            if let prediction = decodable {
                print(prediction)
                self.cities = prediction.predictions
                self.isSearchCity = true
                if self.cities.count > 0 {
                    
                    self.titleForSection.value = "Похожие запросы"
                } else {
                    self.titleForSection.value = "Такого города не существует :("
                }
                complition()
            } else {
                self.titleForSection.value = "Ошибка поиска"
                complition()
                
            }
        }
    }
    
    func getCityNameForCell(at indexPath: IndexPath) -> String {
        if isSearchBarEmpty {
            return recentRequests[indexPath.row].nameForSearch ?? ""
        }
        return cities[indexPath.row].description
    }
    
    func getCitiesCount() -> Int {
        if isSearchBarEmpty {
            return recentRequests.count
        }
        if isSearchCity {
            return cities.count
        }
        return 0
        
    }
    
    func lookCity(indexPath: IndexPath, complition: @escaping ((ShowWeatherInCityViewModelProtocol) -> Void)) {
        if isSearchBarEmpty {
            let request = recentRequests[indexPath.row]
            storageManager.updateDateForRequestID(id: request.id ?? "")
            let viewModel = createShowWeatherInCityViewModel(name: request.name ?? "", lat: request.lat, lng: request.lon, id: request.id ?? "")
            complition(viewModel)
        } else {
            let id = cities[indexPath.row].id
            let searchName = cities[indexPath.row].description
            networkDataFetcher.getData(text: id, searchType: NetworkService.SearchType.coordinates, decodeType: ResultCoordinate.self) {[unowned self] (decodable) in
                guard let response = decodable else { return }
                
                let name = response.result.name
                let lat = response.result.geometry.location.lat
                let lng = response.result.geometry.location.lon
                
                self.storageManager.addRecentRequest(id: id, name: name, nameForRearch: searchName, lat: lat, lon: lng)
                let viewModel = self.createShowWeatherInCityViewModel(name: name, lat: lat, lng: lng, id: id)
                complition(viewModel)
            }
        }
        
    }
    
    func reloadRecentlyRequest() {
        self.recentRequests = storageManager.getRecentRequests().sorted{ $0.date! > $1.date!}
    }
    
    func isTableViewNeedReload(text: String, newText: String) -> Bool {
        isSearchCity = false
        if newText == "" && text.count > 1 {
            return true
        }
        
        if newText == "" && text.count == 0 {
            return false
        }
        
        if newText == "" && text.count == 1 {
            isSearchBarEmpty = true
            titleForSection.value = "Последние запросы"
            return true
        }
        
        if newText != "" && (text.count == 0 || text.count > 0) {
            isSearchBarEmpty = false
            titleForSection.value = ""
            return true
        }
        
        
        return false
    }
    
    private func createShowWeatherInCityViewModel(name: String, lat: Double, lng: Double, id: String) -> ShowWeatherInCityViewModelProtocol {
        let cityCoordinates = CityCoordinates(name: name, lat: lat, lng: lng, id: id)
        let viewModel = ShowWeatherInCityViewModel(cityCoordinates: cityCoordinates)
        return viewModel
    }
    
    
    
    
}
