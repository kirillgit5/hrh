//
//  Extension + UIViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 21.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UIViewController {
    func customizeBackButton(image: UIImage = UIImage(systemName: "chevron.left")!) {
        self.navigationItem.hidesBackButton = true
        let button = UIButton()
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.setImage(image , for: .normal)
        button.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
}
