//
//  MemberViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class MemberViewModel {
    
    private let user: User
    private let idCurrentUser :Int
    
    init(idCurrentUser: Int, user: User)
    {
        self.user = user
        self.idCurrentUser = idCurrentUser
    }
    
    var id: Int
    {
        get
        {
            return user.id ?? 0
        }
    }
    
    var name: String
    {
        get
        {
            return user.name ?? ""
        }
    }
    
    var rol: String
    {
        get
        {
            if idCurrentUser == id{
                return "Administrador"
            }else{
                return "Miembro"
            }
        }
    }
    
   
}
