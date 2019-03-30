//
//  GroupDetailNoteRouteCoordinator.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupDetailRouteCoordinator
{
    
    weak var delegate: GroupDetailRouteCoordinatorDelegate?
    
    var rootViewController: UIViewController
    {
        get
        {
            return navigationController
        }
    }
    
    private let navigationController: UITabBarController
    
    private let groupsRepository: GroupsRepository
    
    init(groupoId: Int, groupsRepository: GroupsRepository)
    {
        self.groupsRepository = groupsRepository
   
        //Item detail
        let groupDetailViewModel = GroupDetailViewModel(groupId: groupoId, groupsRepository: groupsRepository)
        let controllerDetail = GroupDetailViewController(viewModel: groupDetailViewModel)
        controllerDetail.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)

        
        //let secondViewController = controllerDetail
        //secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        
        let tabBarList = [controllerDetail]
        
        self.navigationController = UITabBarController()
        self.navigationController.setViewControllers(tabBarList, animated: true)

    }
    
    func closeDetailConttroller() {
        self.delegate?.groupDetailRouteCoordinatorDelegateFinish(self)
    }
}


protocol GroupDetailRouteCoordinatorDelegate : class
{
    func groupDetailRouteCoordinatorDelegateFinish(_ groupDetailRouteCoordinator: GroupDetailRouteCoordinator)
}

