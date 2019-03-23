//
//  GroupsRepository.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 23/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class GroupsRepository
{
    weak var delegate: GroupsRepositoryDelegate?
    
    private(set) var groups: UserGroups?
    
    func getGroups() {

    }
    
    func add(note: Group)
    {

    }
}

protocol GroupsRepositoryDelegate: class
{
    func udateGroups(_: GroupsRepository, groups: UserGroups)
}
