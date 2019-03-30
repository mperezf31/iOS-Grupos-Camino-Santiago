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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.whenCreated = try values.decode(Date.self, forKey: .whenCreated)
        self.title = try values.decode(String.self, forKey: .title)
        self.description = try values.decode(String.self, forKey: .description)
        self.departurePlace = try values.decode(String.self, forKey: .departurePlace)
        self.departureDate = try values.decode(Date.self, forKey: .departureDate)
        self.arrivalDate = try values.decode(Date.self, forKey: .arrivalDate)

        self.founder = try values.decodeIfPresent(User.self, forKey: .founder)
        self.members = try (values.decodeIfPresent(Array<User>.self, forKey: .members) ?? Array())
        self.posts = try (values.decodeIfPresent(Array<Post>.self, forKey: .posts) ?? Array())
    }
    
}

