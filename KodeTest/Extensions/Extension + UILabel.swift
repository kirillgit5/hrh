//
//  Extension + UILabel.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 20.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, textColor: UIColor = UIColor.white, font: UIFont? = UIFont(name: "system", size: 15)) {
        self.init()
        self.text = text
        tintColor = textColor
        self.font = font
    }
    
    convenience init(text: String, textColor: UIColor, font: UIFont) {
        self.init()
        
    }
}
