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
    var nameForReadMoreButton: Box<String> { get }
    init(attractive: Attarction)
    func getImageURLString() -> String
    func getAttractiveName() -> String
    func getDescription() -> String
    func getLocation() -> LocationMap
}

class ShowAttractionViewModel: ShowAttractionViewModelProtocol {
    
    private let attractive: Attarction
    private var showFullDescription = false
    var nameForReadMoreButton: Box<String> = Box(value: "Читать дальше")
    
    required init(attractive: Attarction) {
        self.attractive = attractive
    }
    
    func getAttractiveName() -> String {
        attractive.name ?? ""
    }
    
    func getDescription() -> String {
        if !showFullDescription {
            showFullDescription = true
            nameForReadMoreButton.value = "Читать дальше"
            return attractive.desc ?? ""
        } else {
            showFullDescription = false
             nameForReadMoreButton.value = "Свернуть"
            return attractive.descfull ?? ""
        }
    }
    
    func getImageURLString() -> String {
        attractive.imageURL ?? ""
    }
    
    func getLocation() -> LocationMap {
        return LocationMap(lat: attractive.lan, lng: attractive.lon)
    }
    
    
    
}
