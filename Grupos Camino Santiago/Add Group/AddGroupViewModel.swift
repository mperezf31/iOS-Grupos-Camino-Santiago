//
//  AddGroupViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class AddGroupViewModel : AddGroupRepositoryDelegate {
    
    weak var delegate: AddGroupViewModelDelegate?
    weak var routingDelegate: AddGroupViewModelRoutingDelegate?
    
    private let groupsRepository: GroupsRepository
    
    init(groupsRepository: GroupsRepository) {
        self.groupsRepository = groupsRepository
        self.groupsRepository.delegateAddGroup = self
    }
    
    func addGroup(groupToAdd: Group) {
        self.groupsRepository.addGroup(groupToAdd: groupToAdd)
    }
    
    func addGroupSuccess(_: GroupsRepository, groupAdded: Group) {
        self.routingDelegate?.dimissAddGroupPage(self)
    }
    
    func dimissAddGroupPage() {
        self.routingDelegate?.dimissAddGroupPage(self)
    }
    
    func error(_: GroupsRepository, errorMsg: String) {
        self.delegate?.error(self,errorMsg: errorMsg)
    }
    
}

protocol AddGroupViewModelDelegate: class
{
    
    func error(_: AddGroupViewModel, errorMsg: String)
    
}

protocol AddGroupViewModelRoutingDelegate: class
{
    func dimissAddGroupPage(_ viewModel: AddGroupViewModel)
}



