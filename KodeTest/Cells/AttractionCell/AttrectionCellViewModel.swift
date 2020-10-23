//
//  AttrectionCellViewModel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

protocol  AttractionCellViewModelProtocol {
    init(attraction: Attarction)
    func getDescription() -> String
    func getName() -> String
    func getImageName() -> String
    
}

class AttractionCellViewModel: AttractionCellViewModelProtocol {
    
    private let attraction: Attarction
    
    required init(attraction: Attarction) {
        self.attraction = attraction
    }
    
    func getDescription() -> String {
        attraction.desc ?? ""
    }
    
    func getName() -> String {
        attraction.name ?? ""
    }
    
    func getImageName() -> String {
        attraction.imageURL ?? ""
        
    }
}

