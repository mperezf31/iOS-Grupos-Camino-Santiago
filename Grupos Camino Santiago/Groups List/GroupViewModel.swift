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
            return group.departureDate?.description ?? ""
        }
    }
}
