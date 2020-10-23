//
//  WeatherCollectionViewCell.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 17.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell",
                     bundle: nil)
    }
    
    var viewModel: WeatherCellViewModelProtocol! {
        didSet {
            timeLabel.text = viewModel.getTime()
            descriptionLabel.text = viewModel.getDescription()
            imageView.image = UIImage(named: viewModel.getImageName())
        }
    }
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK : - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        colorView.layer.cornerRadius = 10
    }

}
