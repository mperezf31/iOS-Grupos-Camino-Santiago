//
//  Group.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//
import UIKit

class Group: NSObject, Codable
{
    var id: Int?
    var photo: String?
    var whenCreated: Date?
    var title: String?
    
    var descriptionGroup: String?
    var departurePlace: String?
    var latitude : Double?
    var longitude : Double?
    var departureDate: Date?
    var arrivalDate: Date?
    var founder: User?
    var members : Array<User> = Array()
    var posts : Array<Post> = Array()
    
    
    override init() {
        
    }
    
    private enum CodingKeys : String, CodingKey {
        case id, photo, whenCreated, title, descriptionGroup = "description", departurePlace, latitude, longitude, departureDate , arrivalDate, founder, members, posts
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.photo = try values.decodeIfPresent(String.self, forKey: .photo)
        self.whenCreated = try values.decode(Date.self, forKey: .whenCreated)
        self.title = try values.decode(String.self, forKey: .title)
        self.descriptionGroup = try values.decode(String.self, forKey: .descriptionGroup)
        self.departurePlace = try values.decode(String.self, forKey: .departurePlace)
        self.latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
        self.longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
        self.departureDate = try values.decode(Date.self, forKey: .departureDate)
        self.arrivalDate = try values.decode(Date.self, forKey: .arrivalDate)

        self.founder = try values.decodeIfPresent(User.self, forKey: .founder)
        self.members = try (values.decodeIfPresent(Array<User>.self, forKey: .members) ?? Array())
        self.posts = try (values.decodeIfPresent(Array<Post>.self, forKey: .posts) ?? Array())
    }

    
}

