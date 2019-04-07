//
//  RegisterViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 07/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//


class RegisterViewModel {
    
    
    weak var delegate: RegisterViewModelDelegate?
    weak var routingDelegate: RegisterViewModelRoutingDelegate?
    
    private let groupsStorage: GroupsStorage
    
    init(groupsStorage: GroupsStorage)
    {
        self.groupsStorage = groupsStorage
    }
    
    
    func registerClick(user: User)
    {
        self.groupsStorage.register(user: user){ (response) in
            
            switch response {
                
            case .success(_):
                self.routingDelegate?.showGroupsList(self)
                
            case let .error(error):
                self.delegate?.error(self, errorMsg: error.msgError)
            }
            
        }
    }
    
}



protocol RegisterViewModelDelegate: class
{
    
    func error(_: RegisterViewModel, errorMsg: String)
    
}

protocol RegisterViewModelRoutingDelegate: class
{
    func showGroupsList(_ viewModel: RegisterViewModel)
    
    func showLogin(_ viewModel: RegisterViewModel)
}
