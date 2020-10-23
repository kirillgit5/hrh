//
//  AttractionInMapViewController.swift
//  KodeTest
//
//  Created by Кирилл Крамар on 21.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import MapKit

class AttractionInMapViewController: UIViewController {

    //MARK: - IB Outlets
    @IBOutlet var map: MKMapView!
    
    //MARK: - Public Methods
    var location: LocationMap!
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegion()
        createAnnotation()
        customizeBackButton()
    }
    
    private func setRegion() {
        let distanceSpan: CLLocationDistance = 1000
        let locationLatLon = CLLocation(latitude: location.lat, longitude: location.lng)
        let mapCoordinates = MKCoordinateRegion(center: locationLatLon.coordinate, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan)
        map.setRegion(mapCoordinates, animated: true)
    }
    
    private func createAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
        map.addAnnotation(annotation)
    }
    
    

}
