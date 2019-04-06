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
        
        self.navigationController.navigationBar.barTintColor =  #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
        self.navigationController.navigationBar.tintColor = #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
        self.navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)]

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
        self.navigationController = UINavigationController(rootViewController: GroupListViewController(viewModel: rootViewModel))
        rootViewModel.routingDelegate = self
    }
    
    
}
