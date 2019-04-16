//
//  GroupsViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation
import UIKit

class GroupViewModel {
    
    let formatter = DateFormatter()
    private let group: Group
    
    init(group: Group)
    {
        self.group = group
        self.formatter.dateFormat = "HH:mm dd/MM/yy"
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
    
    var photo: UIImage
    {
        get
        {
            if let imageBase64 = group.photo{
                return UIImage(imageString: imageBase64) ?? UIImage(named: "Group")!
            }else{
                return UIImage(named: "Group")!
            }
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
    
    var groupPin : GroupPin {
        let groupPin = GroupPin(lat: self.lat, long: self.long)
        groupPin.title = self.title
        groupPin.image = self.photo
        return groupPin
    }
    
    
    var lat: Double
    {
        get
        {
            return group.latitude ?? 0
        }
    }
    
    var long: Double
    {
        get
        {
            return group.longitude ?? 0
        }
    }
    
    var founderPhoto: UIImage
    {
        get
        {
            if let imageBase64 = group.founder?.photo{
                return UIImage(imageString: imageBase64) ?? UIImage(named: "User")!
            }else{
                return UIImage(named: "User")!
            }
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
