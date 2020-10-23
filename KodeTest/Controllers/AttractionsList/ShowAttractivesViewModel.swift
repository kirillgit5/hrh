//
//  ShowAttractivesViewModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

protocol AttractionsListViewModelProtocol {
    init(city: City)
    func getNumberItemsInSection() -> Int
    func getAttrectionCellViewModel(indexPath: IndexPath) -> AttractionCellViewModelProtocol
    func getShowAttractionViewModel(indexPath: IndexPath) -> ShowAttractionViewModelProtocol
}

class AttractionsListViewModel: AttractionsListViewModelProtocol {
    
    private let attractions: [Attarction]
    private let city: City
    
    required init(city: City) {
        self.city = city
        if let attractions = city.attractions?.allObjects as? [Attarction] {
            self.attractions = attractions.sorted{ $0.name! < $1.name! }
        } else {
            attractions = []
        }
    }
    
    func getNumberItemsInSection() -> Int {
        attractions.count
    }
    
    func getAttrectionCellViewModel(indexPath: IndexPath) -> AttractionCellViewModelProtocol {
        let attraction = attractions[indexPath.item]
        return AttractionCellViewModel(attraction: attraction)
    }
    
    func getShowAttractionViewModel(indexPath: IndexPath) -> ShowAttractionViewModelProtocol {
        let attraction = attractions[indexPath.item]
        return ShowAttractionViewModel(attractive: attraction)
    }
}
