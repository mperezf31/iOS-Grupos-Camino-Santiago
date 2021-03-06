//
//  MainRouteCoordinator.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class MainRouteCoordinator: GroupsListViewModelRoutingDelegate, AddGroupViewModelRoutingDelegate , LoginRouteCoordinatorDelegate
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
        self.navigationController.navigationBar.barTintColor =  UIColor(named: "PickledBluewood")
        self.navigationController.navigationBar.tintColor = .white
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "White")!]
        self.navigationController.navigationBar.isTranslucent = false
    }
    
    func groupListViewModeWantsToAddGroup(_ viewModel: GroupListViewModel) {
        let addGroupViewModel = AddGroupViewModel(groupsStorage: groupsStorage)
        addGroupViewModel.routingDelegate = self
        let addGroupViewController = AddGroupViewController(viewModel: addGroupViewModel)
        let navigationController = UINavigationController(rootViewController: addGroupViewController)
        navigationController.navigationBar.barTintColor =  UIColor(named: "PickledBluewood")
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "White")!]
        navigationController.navigationBar.isTranslucent = false
        rootViewController.present(navigationController, animated: true, completion: nil)
    }

    
    func dimissAddGroupPage(_ viewModel: AddGroupViewModel) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
    
    func showGroupDedtail(_ viewModel: GroupListViewModel, routeId : Int) {
        let groupDetailRouteCoordinator = GroupDetailRouteCoordinator(groupoId: routeId, groupsStorage: groupsStorage)
        navigationController.pushViewController(groupDetailRouteCoordinator.rootViewController, animated: true)
        self.groupDetailRouteCoordinator = groupDetailRouteCoordinator
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
