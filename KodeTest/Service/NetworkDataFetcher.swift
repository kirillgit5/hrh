//
//  NetworkDataFetcher.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 15.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    let networkService = NetworkService.shared
    
    func getData<T: Decodable>(text: String, searchType: NetworkService.SearchType, decodeType: T.Type, response: @escaping (T?) -> Void) {
        networkService.fetchData(body: text, searchType: searchType){ (result) in
            switch result {
            case .success(let data):
                do {
                    let cities = try JSONDecoder().decode(T.self, from: data)
                    response(cities)
                } catch let jsonError {
                    print(jsonError.localizedDescription, "   ",text)
                    response(nil)
                }
            case .failure(_ :):
                response(nil)
            }
        }
    }
}
    
