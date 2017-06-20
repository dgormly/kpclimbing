//
//  ClimbData.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 24/5/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import FirebaseDatabase

class ClimbData : NSObject {
    
    var ref: DatabaseReference!
    var lightData = [Light]()
    var wallData = [Wall]()
    var climbLight = [String: UInt8]()
    
    static let sharedInstance: ClimbData = { ClimbData()} ()
    
    override init() {
        super.init()
       }
}


class Wall : NSObject {
    var name: String
    var dif: UInt8
    
    init( name: String, difficulty: UInt8) {
        self.name = name
        dif = difficulty
    }
}


class Light : NSObject {
    var number: UInt8
    var long: Double
    var lat: Double
    
    init(lightNumber: UInt8, long: Double, lat: Double) {
        self.long = long
        self.lat = lat
        number = lightNumber
    }
}
