//
//  MemberViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation
import UIKit

class MemberViewModel {
    
    private let user: User
    private let founder: Bool
    
    init(founder: Bool, user: User)
    {
        self.founder = founder
        self.user = user
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
    
    var photo: UIImage
    {
        get
        {
            if let imageBase64 = user.photo{
                return UIImage(imageString: imageBase64) ?? UIImage(named: "User")!
            }else{
                return UIImage(named: "User")!
            }
        }
    }
    
    var rol: String
    {
        get
        {
            if founder{
                return "Administrador"
            }else{
                return "Miembro"
            }
        }
    }
    
   
}
