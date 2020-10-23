//
//  Servises.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 15.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

//https://api.openweathermap.org/data/2.5/onecall? &exclude=daily&units=metric&appid=46cc44230e059fbc146fc9eb96d659ae

class NetworkService {
    
    enum SearchType {
        case cities
        case coordinates
        case weather
        case attractive
    }
    
    
    static let shared = NetworkService()
    
    private let dataManager = DataManager()
    private let apiKeyGooglePlace = "AIzaSyCbfUOW9Mh-LdotgbNu8hBJ9aBu-1SpBMM"
    private let apiKeyWeatherAPI = "46cc44230e059fbc146fc9eb96d659ae"
    private let apiKeyAttractive = "5ae2e3f221c38a28845f05b6cb0a048658a7b3ffe2e0f6d6f621c7f1"
    
    private init() {}
    
    func fetchData(body: String, searchType: NetworkService.SearchType ,complition: @escaping(Result<Data, Error>) -> Void) {
        guard let url = createURL(body: body, searchType: searchType) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            complition(.success(data))
        }.resume()
    }
    
    
    private func createURL(body: String, searchType: NetworkService.SearchType) -> URL? {
        switch  searchType {
        case .cities:
            let urlString = dataManager.getUrlForCitySearch() + body + dataManager.getParametrsForCitySearch() + apiKeyGooglePlace
            guard let url = URL(string: urlString.encodeUrl) else { return nil }
            return url
        case .coordinates:
            let urlString = dataManager.gerUrlForCoordinateSearch() + body + dataManager.getParametrsForCoordinateSearch() + apiKeyGooglePlace
            guard let url = URL(string: urlString) else { return nil }
            return url
        case .weather:
            let urlString = dataManager.getURLForWeather() + body + dataManager.getParametrsForWeather() + apiKeyWeatherAPI
            guard let url = URL(string: urlString) else { return nil }
            return url
        case .attractive:
            let urlString = dataManager.urlAttractive + body + dataManager.parametrsAttractive + apiKeyAttractive
            guard let url = URL(string: urlString.encodeUrl) else { return nil }
            return url
        }
        
        
    }
    
    
    
    
}
