//
//  MapViewController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 24/5/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let data = ClimbData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        loadData()
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -27.4781, longitude: 153.0343), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapView.setRegion(region, animated: true)
    }

    func loadData() {
        let ref = Database.database().reference()
        print("Retreiving data...")
        
        // Get all Light data.
        ref.child("light").observeSingleEvent(of: .value, with: { snapshot in
            print("Light Data recieved.")
            print(snapshot)
            var count: UInt8 = 1
            for i in snapshot.children {
                print(i)
                if let snap = (i as? DataSnapshot)?.value as? NSDictionary {
                    let clong = snap["long"] as? Double
                    let clat = snap["lat"] as? Double
                    let light = Light(lightNumber: count, long: clong!, lat: clat!)
                    self.data.lightData.append(light)
                    count += 1
                }
            }
            print(self.data.lightData)
        })
        
        ref.child("walls").observeSingleEvent(of: .value, with: { snapshot in
            print("Wall Data recieved.")
            print(snapshot)
            
            var count: UInt8 = 1
            for i in snapshot.children {
                if let snap = (i as? DataSnapshot)?.value as? NSDictionary {
                    let cDif = snap["dif"] as? UInt8
                    let cName = snap["name"] as? String
                    let wall = Wall(name: cName!, difficulty: cDif!)
                    self.data.wallData.append(wall)
                    count += 1
                }
                DispatchQueue.main.async {
                    self.updateMap()
                }
            }
            print(self.data.wallData)
        })
        
        
    }
    
    func updateMap() {
        var count = 0
        for i in self.data.lightData {
            let annotation = MKPointAnnotation()
            annotation.title = data.wallData[count].name
            annotation.subtitle = "Difficulty: \(self.data.wallData[count].dif )"
            annotation.coordinate = CLLocationCoordinate2D(latitude: (i.lat), longitude: (i.long))
            mapView.addAnnotation(annotation)
            mapView.setCenter(annotation.coordinate, animated: true)
            count %= count + 1
        }
    }



    // Here we add disclosure button inside annotation window
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            //println("Pinview was nil")
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
        }
        
        let button = UIButton.init(type: .detailDisclosure) // button with info sign in it
        button.tag = 10
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        pinView?.rightCalloutAccessoryView = button
        
        return pinView
    }

    
    func buttonClicked(sender: UIButton) {
        let id = sender.tag
        print(id)
        performSegue(withIdentifier: "InformationSegue", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
