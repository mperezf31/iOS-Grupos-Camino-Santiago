//
//  LoginViewModel.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 06/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    
    weak var delegate: LoginViewModelDelegate?
    weak var routingDelegate: LoginViewModelRoutingDelegate?
    
    private let groupsStorage: GroupsStorage
    
    init(groupsStorage: GroupsStorage)
    {
        self.groupsStorage = groupsStorage
    }
    
    
    func loginClick(email: String, password: String)
    {
        self.groupsStorage.login(email: email, password: password){ (response) in
            
            switch response {
                
            case .success(_):
                self.routingDelegate?.showGroupsList(self)
                
            case let .error(error):
                self.delegate?.error(self, errorMsg: error.msgError)
            }
            
        }
    }
    
    func goToRegister() {
        self.routingDelegate?.showRegister(self)
    }
    
    
    func error(_: GroupsStorage, error: StorageError) {
        self.delegate?.error(self, errorMsg: error.msgError)
    }
    
}

protocol LoginViewModelDelegate: class
{
    
    func error(_: LoginViewModel, errorMsg: String)
    
}

protocol LoginViewModelRoutingDelegate: class
{
    func showGroupsList(_ viewModel: LoginViewModel)
    
    func showRegister(_ viewModel: LoginViewModel)
}

