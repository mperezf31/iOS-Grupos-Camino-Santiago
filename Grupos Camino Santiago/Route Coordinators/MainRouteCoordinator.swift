//
//  MainRouteCoordinator.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class MainRouteCoordinator: GroupsListViewModelRoutingDelegate,AddGroupViewModelRoutingDelegate
{
  
    var rootViewController: UIViewController
    {
        get
        {
            return navigationController
        }
    }
    
    private let navigationController: UINavigationController
    
    private let groupsRepository: GroupsRepository
    
    init(groupsRepository: GroupsRepository)
    {
        self.groupsRepository = groupsRepository
        let rootViewModel = GroupListViewModel(groupsRepository: groupsRepository)
        let rootVC = GroupListViewController(viewModel: rootViewModel)
        navigationController = UINavigationController(rootViewController: rootVC)
        rootViewModel.routingDelegate = self
    }
    
    
    func groupListViewModeWantsToAddGroup(_ viewModel: GroupListViewModel) {
        let addGroupViewModel = AddGroupViewModel(groupsRepository: groupsRepository)
        addGroupViewModel.routingDelegate = self
        let addGroupViewController = AddGroupViewController(viewModel: addGroupViewModel)
        rootViewController.present(UINavigationController(rootViewController: addGroupViewController), animated: true, completion: nil)
    }

    
    func dimissAddGroupPage(_ viewModel: AddGroupViewModel) {
        rootViewController.dismiss(animated: true, completion: nil)
    }
    
   
}
