//
//  ClimbDao.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 9/7/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import Foundation

class ClimbDao : Dao {
    
    private var climbList = [Climb]()
    
    func create(item: AnyObject) -> Bool {
        guard let climb = item as? Climb else {
            return false
        }
        climbList.append(climb)
        return true
    }
    
    func read(name: String) -> AnyObject {
        return Climb()
    }
    
    func readAll() -> [AnyObject] {
        if climbList.count == 0 {
            let names = ["Bomb", "Idiot Wing", "Date Anatomy"]
            let rating = [10, 17, 12]
            let desc = "Pretty hard"
        
            for i in 0..<3 {
                let climb = Climb()
                climb.name = names[i]
                climb.desc = desc
                climb.rating = Int(rating[i])
            
                climbList.append(climb)
            }
        }
        
        return climbList
    }
    
    func update(item: AnyObject) -> Bool {
        if let index = climbList.index(of: item as! Climb) {
            climbList.remove(at: index)
            print("Climb removed")
            return true
        } else {
            print("Failed to remove climb.")
            return false
        }
    }
    
    func delete(item: AnyObject) -> Bool {
        return true
    }
}
