//
//  Post.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class Post : NSObject, Codable
{

    var id: Int?
    var whenSent: TimeInterval?
    var content: String?
    var author: User?
}

