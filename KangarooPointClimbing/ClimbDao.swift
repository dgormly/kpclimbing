//
//  ClimbDao.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 9/7/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import Foundation
import FirebaseDatabase

class ClimbDao {
    
    func create(item: AnyObject) -> Bool {
        let ref = Database.database().reference()
        var dict = [String: AnyObject]()
        
        guard let climb = item as? Climb else {
            return false
        }
        
        // Create Dictionary
        dict["rating"] = climb.rating as AnyObject
        dict["wall"] = climb.wall as AnyObject
        
        // Connect to database
        ref.child("climbs").child(climb.name).setValue(dict)
        return true
    }
    
    func read(name: String) -> AnyObject {
        let ref = Database.database().reference()
        ref.child("climbs").child(name).observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot)
        })
        return Climb()
    }
    
    
    func readAll(completionHandler: @escaping ([Climb]) -> ()) {
        var climbList = [Climb]()
        let ref = Database.database().reference()
        ref.child("climbs").observeSingleEvent(of: .value, with: { snapshot in
            for climbSnap in snapshot.children {
                let snap = climbSnap as! DataSnapshot
                let snapshotValue = snap.value as? [String : AnyObject] ?? [:]
                let climb = Climb()
                climb.name = snap.key
                climb.rating = snapshotValue["rating"] as! Int
                climb.wall = snapshotValue["wall"] as! String
                
                climbList.append(climb)
            }
            
            completionHandler(climbList)
        })
//
//        if climbList.count == 0 {
//            let names = ["Bomb", "Idiot Wing", "Date Anatomy"]
//            let rating = [10, 17, 12]
//            let desc = "Pretty hard"
//        
//            for i in 0..<3 {
//                let climb = Climb()
//                climb.name = names[i]
//                climb.desc = desc
//                climb.rating = Int(rating[i])
//            
//                climbList.append(climb)
//            }
//        }
        
    }
    
    func update(item: AnyObject) -> Bool {
//        if let index = climbList.index(of: item as! Climb) {
//            print("Climb removed")
//        
//        } else {
//            print("Failed to remove climb.")
//            return false
//        }
        return true
    }
    
    func delete(item: AnyObject) -> Bool {
        return true
    }
}
