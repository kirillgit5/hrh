//
//  CollectionViewCell.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 19.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class AttrectionViewCell: UICollectionViewCell {
    
    static let identifier = "AttrectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AttrectionViewCellIB",
                     bundle: nil)
    }
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    var viewModel: AttractionCellViewModelProtocol! {
        didSet {
            if !isReuseCell {
                setupCell()
            }
            nameLabel.text = viewModel.getName()
            descLabel.text = viewModel.getDescription()
            let url = viewModel.getImageName()
            if !url.isEmpty {
                imageView.fetchImage(from: url)
            }
        }
    }
        
    private var isReuseCell = false
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        
    }
    
    private func setupCell() {
        imageView.setupLinearGradient(cornerRadius: 10)
        colorView.layer.cornerRadius = 10
        isReuseCell = true
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
    }
    
    
    
}
