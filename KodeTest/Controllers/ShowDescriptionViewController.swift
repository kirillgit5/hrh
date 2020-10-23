//
//  ShowDescriptionViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 21.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class ShowDescriptionViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var textView: UITextView!
    
    var fullDescription: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = fullDescription
        textView.delegate = self
    }
    
     func textViewShouldBeginEditing(_ textView: UITextView) -> Bool  {
        false
    }

}
