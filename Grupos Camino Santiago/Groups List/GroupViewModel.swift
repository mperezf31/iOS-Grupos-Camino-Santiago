//
//  GroupsViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class GroupViewModel {
    
    private let group: Group
    
    init(group: Group)
    {
        self.group = group
    }
    
    var title: String
    {
        get
        {
            return group.title ?? ""
        }
    }
    
    var departureDate: String
    {
        get
        {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            if let date = group.departureDate{
                return "Salida el día " + formatter.string(from: date)
            }else{
                return "Fecha salida: Sin definir"
            }
        }
    }
}
