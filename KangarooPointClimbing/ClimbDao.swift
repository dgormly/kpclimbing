//
//  ClimbDao.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 9/7/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import Foundation

class ClimbDao : Dao {
    
    func create() -> AnyObject {
        return Climb()
    }
    
    func read(name: String) -> AnyObject {
        return Climb()
    }
    
    func readAll() -> [AnyObject] {
        var climbs = [Climb]()
        
        let names = ["Bomb", "Idiot Wing", "Date Anatomy"]
        let rating = [10, 17, 12]
        let desc = "Pretty hard"
        
        for i in 0..<3 {
            let climb = Climb()
            climb.name = names[i]
            climb.desc = desc
            climb.rating = Int8(rating[i])
            
            climbs.append(climb)
        }
        
        return climbs
    }
    
    func update(item: AnyObject) -> Bool {
        return true
    }
    
    func delete(item: AnyObject) -> Bool {
        return true
    }
}
