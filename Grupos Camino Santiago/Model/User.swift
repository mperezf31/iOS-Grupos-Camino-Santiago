//
//  User.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//


class User : Codable
{
    var id: Int?
    var photo: String?
    var name: String?
    var email: String?
    var password: String?
    
    init() {
        
    }
    
    init(email: String,password: String ) {
        self.email = email
        self.password = password
    }
    
}

