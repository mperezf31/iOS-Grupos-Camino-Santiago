//
//  Group.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//
import UIKit

class Group: Codable
{
    var id: Int?
    var whenCreated: Date?
    var title: String?
    var description: String?
    var departurePlace: String?
    var departureDate: Date?
    var arrivalDate: Date?
    var founder: User?
    var members : Array<User> = Array()
    var posts : Array<Post> = Array()
    
    init(_ title: String,_ description: String,_ departurePlace: String,_ departureDate: Date,_ arrivalDate: Date ) {
        self.title = title
        self.description = description
        self.departurePlace = departurePlace
        self.departureDate = departureDate
        self.arrivalDate = arrivalDate
    }
    
}

