//
//  AddGroupViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class AddGroupViewModel {
    
    weak var delegate: AddGroupViewModelDelegate?
    weak var routingDelegate: AddGroupViewModelRoutingDelegate?
    
    private let groupsStorage: GroupsStorage
    
    init(groupsStorage: GroupsStorage) {
        self.groupsStorage = groupsStorage
    }
    
    func addGroup(groupToAdd: Group) {
        self.delegate?.showIndicator(self, msg: "Creando grupo...")

        self.groupsStorage.addGroup(groupToAdd: groupToAdd){ (response) in
            self.delegate?.hideIndicator(self)

            switch response {
            
            case .success(_):
                self.routingDelegate?.dimissAddGroupPage(self)

            case let .error(error):
                self.delegate?.error(self,errorMsg: error.msgError)
            }
        }
    }
    
    
    func dimissAddGroupPage() {
        self.routingDelegate?.dimissAddGroupPage(self)
    }
    
}

protocol AddGroupViewModelDelegate: class
{
    func showIndicator(_: AddGroupViewModel, msg: String)
    
    func hideIndicator(_: AddGroupViewModel)
    
    func error(_: AddGroupViewModel, errorMsg: String)
    
}

protocol AddGroupViewModelRoutingDelegate: class
{
    func dimissAddGroupPage(_ viewModel: AddGroupViewModel)
}



