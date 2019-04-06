//
//  LoginRouteCoordinator.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 06/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class LoginRouteCoordinator : LoginViewModelRoutingDelegate {
    
    weak var delegate: LoginRouteCoordinatorDelegate?

    var rootViewController: UIViewController
    private let groupsStorage: GroupsStorage

    init(groupsStorage: GroupsStorage)
    {
        self.groupsStorage = groupsStorage
        let rootViewModel = LoginViewModel(groupsStorage: groupsStorage)
        self.rootViewController = LoginViewController(viewModel: rootViewModel)
        rootViewModel.routingDelegate = self
    }
    
    
    func showGroupsList(_ viewModel: LoginViewModel) {
        
    }
    
    func showRegisgter(_ viewModel: LoginViewModel) {
        
    }
    
}


protocol LoginRouteCoordinatorDelegate : class
{
    func loginRouteCoordinatorDelegateFinish(_ loginRouteCoordinator: LoginRouteCoordinator)
}
