//
//  Post.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class Post : Decodable
{
    
    var id: Int?
    var content: String?
    var author: User?
}
