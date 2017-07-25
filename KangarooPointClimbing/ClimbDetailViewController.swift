//
//  ClimbDetailViewController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 20/6/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import UIKit
import MapKit

class ClimbDetailViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var climb = Climb()
    let climbDao = ClimbDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        loadMap()
        self.title = climb.name
        locationLabel.text = climb.wall
        difficultyLabel.text = String(climb.rating)
        
        climbDao.readDescription(name: climb.name, completionHandler: { desc in
            self.climb.desc = desc
            self.descriptionTextField.text = desc
        })
    }

    
    func loadMap() {
        let annotation = MKPointAnnotation()
        let coordinate = CLLocationCoordinate2D(latitude: -27.4781, longitude: 153.0343)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
        
    }

}
