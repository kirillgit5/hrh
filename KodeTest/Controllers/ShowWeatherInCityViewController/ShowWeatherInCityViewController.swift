//
//  ShowWeatherInCityViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 16.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import MapKit

class ShowWeatherInCityViewController: UIViewController {
    
    @IBOutlet var map: MKMapView!
    @IBOutlet var currentDateLabel: UILabel!
    @IBOutlet var tomorrowDateLabel: UILabel!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var currentWeatherCollectioView: UICollectionView!
    @IBOutlet var tomorrowWeatherCollectionView: UICollectionView!
    
    @IBOutlet var attractionsButton: UIButton!
    
    var viewModel: ShowWeatherInCityViewModelProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designViews()
        setupCollectionViews()
        createAnnotation()
        setRegion()
        reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let showVC = segue.destination as? AttractionsListViewController else { return }
        guard let viewModel = sender as? AttractionsListViewModelProtocol else { return }
        showVC.viewModel = viewModel
    }
    
    //MARK: Private Methods
    private func reloadData() {
        viewModel.reloadData {[unowned self] in
            DispatchQueue.main.async {
                self.currentWeatherCollectioView.reloadData()
                self.tomorrowWeatherCollectionView.reloadData()
            }
        }
    }
    
    
    private func createAnnotation() {
        let annotation = MKPointAnnotation()
        let location = viewModel.getLocation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        map.addAnnotation(annotation)
    }
    
    private func setRegion() {
        let distanceSpan: CLLocationDistance = 800000
        let location = viewModel.getLocation()
        let locationLatLon = CLLocation(latitude: location.lat, longitude: location.lng)
        let mapCoordinates = MKCoordinateRegion(center: locationLatLon.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        map.setRegion(mapCoordinates, animated: true)
    }
    
    private func setupCollectionViews() {
        currentWeatherCollectioView.delegate = self
        currentWeatherCollectioView.dataSource = self
        tomorrowWeatherCollectionView.delegate = self
        tomorrowWeatherCollectionView.dataSource = self
        currentWeatherCollectioView.register(WeatherHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: WeatherHeader.reuseId)
        tomorrowWeatherCollectionView.register(WeatherHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: WeatherHeader.reuseId)
        currentWeatherCollectioView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
        tomorrowWeatherCollectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: WeatherCollectionViewCell.identifier)
    }
    
    private func designViews() {
        cityNameLabel.text = viewModel.getCityName()
        currentDateLabel.text = viewModel.getCurrentDateForShow()
        tomorrowDateLabel.text = viewModel.getTomorrowDateForShow()
        attractionsButton.layer.cornerRadius = 10
        attractionsButton.isHidden = viewModel.isAttractiveButtonHidden()
        customizeBackButton()
    }
    
    
    @IBAction func showAttrections(_ sender: Any) {
        performSegue(withIdentifier: SegueIdentifiers.showAttrections.rawValue, sender: viewModel.getViewModelForAttrectiveVC())
    }
    
    
}

//MARK: - UICollectionViewDelegate
extension ShowWeatherInCityViewController: UICollectionViewDelegate {
    
    
}

extension ShowWeatherInCityViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === currentWeatherCollectioView {
            return viewModel.getCountItem(type: ShowWeatherInCityViewModel.WeatherCollectionType.current)
        } else {
            return viewModel.getCountItem(type: ShowWeatherInCityViewModel.WeatherCollectionType.tomorrow)
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        if collectionView === currentWeatherCollectioView {
            let cellViewModel = viewModel.createViewModelFor(indexPath: indexPath, type: ShowWeatherInCityViewModel.WeatherCollectionType.current)
            cell.viewModel = cellViewModel
            print(cell.contentView.frame.size.height)
        } else {
            let cellViewModel = viewModel.createViewModelFor(indexPath: indexPath, type: ShowWeatherInCityViewModel.WeatherCollectionType.tomorrow)
            cell.viewModel = cellViewModel
        }
        return cell
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ShowWeatherInCityViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}
