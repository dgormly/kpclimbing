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

class NewClimbController : UIViewController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var location = CLLocation()
    var climbDao = ClimbDao()
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var wallNameTextfield: UITextField!
    @IBOutlet weak var difTextfield: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    @IBAction func getLocation(_ sender: Any) {
        
    }
    
    @IBAction func submitClimb(_ sender: Any) {
        let name = nameTextfield.text
        let wallName = wallNameTextfield.text
        let dif = Int(difTextfield.text!)
        let climb = Climb()
        
        climb.name = name!
        climb.rating = dif!
        climb.wall = wallName!
        
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
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
}
