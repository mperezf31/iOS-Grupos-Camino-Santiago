//
//  LoginRouteCoordinator.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 06/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class LoginRouteCoordinator : LoginViewModelRoutingDelegate, RegisterViewModelRoutingDelegate {

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
        showGroupsList()
    }
    
    func showRegister(_ viewModel: LoginViewModel) {
        let registerViewModel = RegisterViewModel(groupsStorage: groupsStorage)
        let registerViewController = RegisterViewController(viewModel: registerViewModel)
        self.rootViewController.show(registerViewController, sender: nil)
        registerViewModel.routingDelegate = self
    }
    
    func showGroupsList(_ viewModel: RegisterViewModel) {
        showGroupsList()
    }
    
    func showLogin(_ viewModel: RegisterViewModel) {
        let rootViewModel = LoginViewModel(groupsStorage: groupsStorage)
        self.rootViewController = LoginViewController(viewModel: rootViewModel)
        rootViewModel.routingDelegate = self
    }
    
    func showGroupsList() {
     
    }
    
}


protocol LoginRouteCoordinatorDelegate : class
{
    func loginRouteCoordinatorDelegateFinish(_ loginRouteCoordinator: LoginRouteCoordinator)
}
