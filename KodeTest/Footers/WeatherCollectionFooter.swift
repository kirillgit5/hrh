//
//  WeatherCollectionFooter.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 17.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class WeatherHeader: UICollectionReusableView {
    static let reuseId = "WeatherSectionHeader"
    private let infoLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(infoLable)
        infoLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            infoLable.topAnchor.constraint(equalTo: self.topAnchor),
            infoLable.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
    func configure(text: String, font: UIFont?, textColor: UIColor?) {
        infoLable.text = text
        infoLable.font = font
        infoLable.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

