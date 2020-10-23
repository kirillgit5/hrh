//
//  Extension + String.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

import UIKit
extension String{
    var encodeUrl : String
    {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String
    {
        return self.removingPercentEncoding!
    }
    
    func countingWords() -> [String] {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return words
    }
}
