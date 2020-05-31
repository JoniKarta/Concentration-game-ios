//
//  Location.swift
//  Concentration-Game
//
//  Created by user165579 on 5/31/20.
//  Copyright © 2020 user165579. All rights reserved.
//

import Foundation

class Location :CustomStringConvertible, Codable{
    
    var lat : Double = 0
    var lng : Double = 0
    
    init(){
        
    }
    init(lat: Double, lng: Double){
        self.lat = lat
        self.lng = lng
    }
    
    public var description: String {
        return "Location Details: \n Latitude: \(self.lat)\n Longitude: \(self.lng)"
    }
}

