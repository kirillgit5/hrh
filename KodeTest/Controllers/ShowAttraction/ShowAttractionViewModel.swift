//
//  ShowAttractionViewModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 21.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import MapKit
import CoreData

protocol ShowAttractionViewModelProtocol {
    init(attractive: Attarction)
    func getImageURLString() -> String
    func getAttractiveName() -> String
    func getDescription() -> String
    func getLocation() -> LocationMap
    func getFullDescription() -> String
}

class ShowAttractionViewModel: ShowAttractionViewModelProtocol {
    
    
    
    private let attractive: Attarction
    required init(attractive: Attarction) {
        self.attractive = attractive
    }
    
    func getAttractiveName() -> String {
        attractive.name ?? ""
    }
    
    func getDescription() -> String {
        attractive.desc ?? ""
    }
    
    func getImageURLString() -> String {
        attractive.imageURL ?? ""
    }
    
    func getLocation() -> LocationMap {
        print(attractive.lan, " attractive.lan ")
        print(attractive.lon, " attractive.lon")
        return LocationMap(lat: attractive.lan, lng: attractive.lon)
    }
    
    func getFullDescription() -> String {
        attractive.descfull ?? ""
    }
    
}
