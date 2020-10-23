//
//  Extension + UIButton.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 20.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String, textColor: UIColor = .white, backgroundColor: UIColor = .lightGray) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        tintColor = textColor
        layer.cornerRadius = 10
    }
}
