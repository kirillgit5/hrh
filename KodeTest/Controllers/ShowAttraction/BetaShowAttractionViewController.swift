//
//  BetaShowAttractionViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 21.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class BetaShowAttractionViewController: UIViewController, UIScrollViewDelegate {
    
    var viewModel: ShowAttractionViewModelProtocol!
    
    private let scrollView = UIScrollView()
    var contentView = UIView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel(text: "", textColor: .white, font: UIFont(name: "system", size: 34))
    private let descLabel = UILabel(text: "", textColor: .white)
    private let inMapLabel = UILabel(text: "На карте", textColor: .white, font: UIFont(name: "system", size: 34))
    
    private let readModeButton = UIButton(title: "Читать ещё")
    private let showInMap = UIButton(title: "Показать на карте", textColor: .white, backgroundColor: .systemGray)
    
    private let map = MKMapView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        setupContentInViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    private func setupContentInViews() {
        imageView.fetchImage(from: viewModel.getImageURLString())
        nameLabel.text = viewModel.getAttractiveName()
        descLabel.text = viewModel.getDescription()
        scrollView.contentInsetAdjustmentBehavior = .never
        descLabel.numberOfLines = 0
        imageView.contentMode = .scaleAspectFill
        setRegion()
        createAnnotation()
        nameLabel.backgroundColor = .red
        descLabel.backgroundColor = .blue
    }
    
    private func setRegion() {
        let distanceSpan: CLLocationDistance = 1000
        let location = viewModel.getLocation()
        let locationLatLon = CLLocation(latitude: location.lat, longitude: location.lng)
        let mapCoordinates = MKCoordinateRegion(center: locationLatLon.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        map.setRegion(mapCoordinates, animated: true)
    }
    
    private func createAnnotation() {
        let annotation = MKPointAnnotation()
        let location = viewModel.getLocation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        map.addAnnotation(annotation)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(imageView.frame.height)
        print()
    }
    
    private func setupLayouts() {
        scrollView.delegate = self
        
        let imageContainer = UIView()
        let contentBacking = UIView()
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(contentBacking)
        scrollView.addSubview(imageContainer)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(readModeButton)
        contentView.addSubview(map)
        contentView.addSubview(inMapLabel)
        contentView.addSubview(showInMap)
        contentView.backgroundColor = .yellow
        
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(descLabel)
//        contentView.addSubview(readModeButton)
//        contentView.addSubview(map)
//        contentView.addSubview(inMapLabel)
//        contentView.addSubview(showInMap)
        
//        scrollView.snp.makeConstraints { (make) in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
//            make.leading.equalTo(view)
//            make.trailing.equalTo(view)
//            make.height.equalTo(1000)
//        }
        
        scrollView.snp.makeConstraints {
            make in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        imageContainer.snp.makeConstraints {
            make in
            
            make.top.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.height.equalTo(200)
        }
        
        imageView.snp.makeConstraints {
            make in
            
            make.left.right.equalTo(imageContainer)

            //** Note the priorities
            make.top.equalTo(view).priority(.high)
            
            //** We add a height constraint too
            make.height.greaterThanOrEqualTo(imageContainer.snp.height).priority(.required)
            
            //** And keep the bottom constraint
            make.bottom.equalTo(imageContainer.snp.bottom)
        }
        
        contentView.snp.makeConstraints {
            make in
            make.top.equalTo(imageContainer.snp.bottom).offset(34)
            make.left.right.equalTo(view)
            make.bottom.equalTo(scrollView)
        }
        
        contentBacking.snp.makeConstraints {
                  make in
                  make.left.right.equalTo(view)
                  make.top.equalTo(contentView)
                  make.bottom.equalTo(view)
              }

        

        
    
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top)
            make.left.equalTo(view.snp.left).inset(24)
            make.right.equalTo(view.snp.right).inset(24)
            make.height.equalTo(96)
        }
//
//        descLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(nameLabel.snp.bottom).offset(-14)
//            make.left.equalTo(view).inset(24)
//            make.right.equalTo(view).inset(24)
//            make.height.equalTo(72)
//        }
//
//        readModeButton.snp.makeConstraints { (make) in
//            make.top.equalTo(descLabel)
//            make.left.equalTo(view).inset(24)
//        }
//
//        inMapLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(readModeButton).inset(32)
//            make.left.equalTo(view).inset(24)
//            make.right.equalTo(view).inset(-24)
//        }
//
//        map.snp.makeConstraints { (make) in
//            make.top.equalTo(inMapLabel).inset(16)
//            make.left.equalTo(view)
//            make.right.equalTo(view)
//        }
//
//        showInMap.snp.makeConstraints { (make) in
//            make.top.equalTo(inMapLabel).inset(16)
//            make.left.equalTo(view).offset(24)
//            make.right.equalTo(view).offset(-24)
//        }
        
    }
    private var previousStatusBarHidden = false
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            if previousStatusBarHidden != shouldHideStatusBar {
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.setNeedsStatusBarAppearanceUpdate()
                })
                
                previousStatusBarHidden = shouldHideStatusBar
            }
        }
        
        //MARK: - Status Bar Appearance
        
        override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
            return .slide
        }
        
        override var prefersStatusBarHidden: Bool {
            return shouldHideStatusBar
        }
        
        private var shouldHideStatusBar: Bool {
            let frame = contentView.convert(contentView.bounds, to: nil)
            return frame.minY < view.safeAreaInsets.top
        }
    }



