//
//  MainRouteCoordinator.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class MainRouteCoordinator: GroupsListViewModelRoutingDelegate, AddGroupViewModelRoutingDelegate , GroupDetailRouteCoordinatorDelegate , LoginRouteCoordinatorDelegate
{
    
    var rootViewController: UIViewController
    {
        get
        {
            return navigationController
        }
    }
    
    private var navigationController: UINavigationController
    
    private var loginRouteCoordinator: LoginRouteCoordinator?
    private var groupDetailRouteCoordinator: GroupDetailRouteCoordinator?

    private let groupsStorage: GroupsStorage
    
    init(groupsStorage: GroupsStorage)
    {
        self.groupsStorage = groupsStorage
        
        if let _ = groupsStorage.getAuthUserId(){
            let rootViewModel = GroupListViewModel(groupsStorage: groupsStorage)
            self.navigationController = UINavigationController(rootViewController: GroupListViewController(viewModel: rootViewModel))
            rootViewModel.routingDelegate = self
            
        }else{
            let loginRouteCoordinator = LoginRouteCoordinator(groupsStorage: groupsStorage)
            self.navigationController = UINavigationController(rootViewController: loginRouteCoordinator.rootViewController)
            loginRouteCoordinator.delegate = self
            self.loginRouteCoordinator = loginRouteCoordinator
        }
        
        customizeNavigationController()
    }
    
    private func customizeNavigationController() {
        self.navigationController.navigationBar.barTintColor =  #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
        self.navigationController.navigationBar.tintColor = .white
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)]
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func groupListViewModeWantsToAddGroup(_ viewModel: GroupListViewModel) {
        let addGroupViewModel = AddGroupViewModel(groupsStorage: groupsStorage)
        addGroupViewModel.routingDelegate = self
        let addGroupViewController = AddGroupViewController(viewModel: addGroupViewModel)
        rootViewController.present(UINavigationController(rootViewController: addGroupViewController), animated: true, completion: nil)
    }

    
    func dimissAddGroupPage(_ viewModel: AddGroupViewModel) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func showGroupDedtail(_ viewModel: GroupListViewModel, routeId : Int) {
        let groupDetailRouteCoordinator = GroupDetailRouteCoordinator(groupoId: routeId, groupsStorage: groupsStorage)
        groupDetailRouteCoordinator.delegate = self
        navigationController.pushViewController(groupDetailRouteCoordinator.rootViewController, animated: true)
        self.groupDetailRouteCoordinator = groupDetailRouteCoordinator
    }
    
    func groupDetailRouteCoordinatorDelegateFinish(_ groupDetailRouteCoordinator: GroupDetailRouteCoordinator) {
        rootViewController.dismiss(animated: true, completion: nil)
        self.groupDetailRouteCoordinator = nil
    }
    
    func loginRouteCoordinatorDelegateFinish(_ loginRouteCoordinator: LoginRouteCoordinator) {
        let rootViewModel = GroupListViewModel(groupsStorage: groupsStorage)
        let groupListViewController = GroupListViewController(viewModel: rootViewModel)
        rootViewModel.routingDelegate = self
        navigationController.setViewControllers([groupListViewController], animated: true)
    }
    
    
    func showLogin(_ viewModel: GroupListViewModel) {
        
        let loginRouteCoordinator = LoginRouteCoordinator(groupsStorage: groupsStorage)
        navigationController.setViewControllers([loginRouteCoordinator.rootViewController], animated: true)
        loginRouteCoordinator.delegate = self
        self.loginRouteCoordinator = loginRouteCoordinator
    }
    
    
}
