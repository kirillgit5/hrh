//
//  GradientView.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 20.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    enum Point {
        case topLeading
        case leading
        case bottomLeading
        case top
        case center
        case bottom
        case topTrailing
        case trailing
        case bottomTrailing
        case topCenter
        case bottomCenter
        case linearGradient
        
        var point: CGPoint {
            switch self {
            case .topLeading:
                return CGPoint(x: 0, y: 0)
            case .leading:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeading:
                return CGPoint(x: 0, y: 1.0)
            case .top:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottom:
                return CGPoint(x: 0.5, y: 1.0)
            case .topTrailing:
                return CGPoint(x: 1.0, y: 0.0)
            case .trailing:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomTrailing:
                return CGPoint(x: 1.0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case . bottomCenter:
                return CGPoint(x: 0.5, y: 1)
            case .linearGradient:
                return CGPoint(x: 0, y: 8)
            }
        }
    }
    
    convenience init(frame: CGRect, startPoint: Point, endPoint: Point, startColor: UIColor, endColor: UIColor) {
        self.init(frame: frame)
        setupLinearGradient(startPoint: startPoint, endPoint: endPoint, startColor: startColor, endColor: endColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLinearGradient(startPoint : Point, endPoint: Point, startColor: UIColor, endColor: UIColor) {
        self.layer.addSublayer(gradientLayer)
        gradientLayer.startPoint = startPoint.point
        gradientLayer.endPoint = endPoint.point
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.locations = [0, 0.9,1]
    }
}
