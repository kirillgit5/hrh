//
//  TestVCViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class TestVCViewController: UIViewController {

    private var attractive: [Attractive] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//      let networkFetcher = NetworkDataFetcher()
//                   DispatchQueue.global(qos: .utility).async {
//                       
//                       for  (id, XDS) in DataManager().attractionsFirst {
//                        sleep(3)
//                           for idsf in XDS {
//                              
//                                  networkFetcher.getData(text: idsf, searchType: NetworkService.SearchType.attractive, decodeType: Attractive.self) { (decodable) in
//                                      guard let decodableQ = decodable else { return }
//                                    print(decodableQ.name)
//                                      
//                                      }
//                           }
//                                  
//                              }
//                   }
        sleep(2)
        print(attractive.count)
    }
}



