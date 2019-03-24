//
//  UserGroups.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

class UserGroups : Codable
{
    var groupsCreated: Array<Group> = Array()
    var groupsAssociated: Array<Group> = Array()
    var otherGroups: Array<Group> = Array()
}
