//
//  NewClimbController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 12/7/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NewClimbController : UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var locationManager = CLLocationManager()
    var climbDao = ClimbDao()
    var climb = Climb()
    
    var location: CLLocationCoordinate2D!
    
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var wallNameTextfield: UITextField!
    @IBOutlet weak var difTextfield: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // TODO -  Implement function to grab the users' current location.
    @IBAction func getLocation(_ sender: Any) {
        
    }
    
    @IBAction func submitClimb(_ sender: Any) {
        let name = nameTextfield.text
        let wallName = wallNameTextfield.text
        let dif = Int(difTextfield.text!)
        
        climb.name = name!
        climb.rating = dif!
        climb.wall = wallName!
        climb.longLoc = location.longitude
        climb.latLoc = location.latitude
        
        let climbStatus = climbDao.create(item: climb)
        if climbStatus {
            print("Successfully added new climb")
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Failed to add new climb")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        if !self.climb.isEqual(Climb()) {
            nameTextfield.text = climb.name
            wallNameTextfield.text = climb.wall
        }
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func loadMap() {
       let userLocation = mapView.userLocation.coordinate
        let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.region = region
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        climb.longLoc = (manager.location?.coordinate.longitude)!
        climb.latLoc = (manager.location?.coordinate.latitude)!
        
        print("location: \(self.climb.latLoc) \(self.climb.longLoc)")
        manager.stopUpdatingLocation()
    }
    
}
