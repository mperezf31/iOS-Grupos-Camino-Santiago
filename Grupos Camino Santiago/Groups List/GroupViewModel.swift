//
//  GroupsViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class GroupViewModel {
    
    let formatter = DateFormatter()
    private let group: Group
    
    init(group: Group)
    {
        self.group = group
        self.formatter.dateFormat = "dd/MM/yyyy"
    }
    
    var id: Int
    {
        get
        {
            return group.id ?? 0
        }
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
            if let date = group.departureDate{
                return formatter.string(from: date)
            }else{
                return ""
            }
        }
    }
    
    var arrivalDate: String
    {
        get
        {
            if let date = group.arrivalDate{
                return formatter.string(from: date)
            }else{
                return ""
            }
        }
    }
    
    var description: String
    {
        get
        {
            return group.description ?? ""
        }
    }
    
    var departurePlace: String
    {
        get
        {
            return group.departurePlace ?? ""
        }
    }
    
    var founderName: String
    {
        get
        {
            return group.founder?.name ?? ""
        }
    }
    
    var founderEmail: String
    {
        get
        {
            return group.founder?.email ?? ""
        }
    }
    
}
