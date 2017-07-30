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
    
    func read(name: String, completionHandler: @escaping (Climb) -> ()) {
        let ref = Database.database().reference()
        let climb = Climb()
        ref.child("climbs").child(name).observeSingleEvent(of: .value, with: { snapshot in
            let snapshotValue = snapshot.value as? [String : AnyObject] ?? [:]
            climb.name = name
            climb.rating = snapshotValue["rating"] as! Int
            climb.wall = snapshotValue["wall"] as! String
            
        })
        completionHandler(climb)
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
    }
    
    
    func readDescription(name: String, completionHandler: @escaping (String) -> ()) {
        let ref = Database.database().reference()
        var desc: String = ""
        ref.child("climbDesc").child(name).observeSingleEvent(of: .value, with: { snapshot in
            let snapValue = snapshot.value as? [String : String] ?? [:]
            desc = snapValue["desc"] ?? "No description found"
            completionHandler(desc)
        })
    }
    
    
    func update(item: Climb) {
        let ref = Database.database().reference()
        ref.child("climbs").child(item.name).removeValue()
        let _ = self.create(item: item)
    }
    
    
    
    func delete(item: AnyObject) -> Bool {
        return true
    }
}
