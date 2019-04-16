//
//  GroupPin.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 16/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class GroupPin: NSObject, MKAnnotation
{
    
    var title : String?
    var image : UIImage?
    var latitude : Double
    var longitude : Double
    
    var coordinate : CLLocationCoordinate2D
    {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(lat: Double, long: Double)
    {
        self.latitude = lat
        self.longitude = long
    }
}
