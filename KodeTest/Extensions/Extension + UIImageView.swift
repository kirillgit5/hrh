//
//  Extension + UIImageView.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

extension UIImageView {
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else { return }
        if let cachedImage = getCacheImage(url: url) {
            image = cachedImage
            return
        }
        
        ImageService.shared.getImage(from: url) {[weak self] (data, response) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            self.saveDataToCach(with: data, response: response)
        }
    }
    
    private func getCacheImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let chacheedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: chacheedResponse.data)
        }
       return nil
    }
    
    private func saveDataToCach(with data: Data, response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let chacheedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(chacheedResponse, for: urlRequest)
         
    }
    
    
    func setupLinearGradient(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let color = UIColor(white: 0, alpha: 0)
        let gradientView = GradientView(frame: .zero, startPoint: .topCenter, endPoint: .bottomCenter, startColor: color, endColor: .black)
        
        guard let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer else { return }
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
