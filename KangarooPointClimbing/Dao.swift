//
//  Dao.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 9/7/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import Foundation

protocol Dao {
    
    func create() -> AnyObject
    
    func read(name: String) -> AnyObject
    
    func readAll() -> [AnyObject]
    
    func update(item: AnyObject) -> Bool
    
    func delete(item: AnyObject) -> Bool
    
}
