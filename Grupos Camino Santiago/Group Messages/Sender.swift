//
//  GroupMessage.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 17/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import MessengerKit

struct Sender : MSGUser {
    
    var displayName: String
    
    var avatar: UIImage?
    
    var isSender: Bool
    
    init(displayName: String, avatar: UIImage, isSender: Bool) {
        self.displayName = displayName
        self.avatar = avatar
        self.isSender = isSender
    }
    
}
