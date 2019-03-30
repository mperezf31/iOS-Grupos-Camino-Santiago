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
        let groupDetailViewController = GroupDetailViewController(viewModel: groupDetailViewModel)
        groupDetailViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)

        
        //Item members
        let groupMembersViewModel = GroupMembersViewModel(groupId: groupoId, groupsRepository: groupsRepository)
        let groupMembersViewController = GroupMembersViewController(viewModel: groupMembersViewModel)
        groupMembersViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)

        //Group posts
        let groupPostsViewModel = GroupPostsViewModel(groupId: groupoId, groupsRepository: groupsRepository)
        let groupPostsViewController = GroupPostsViewController(viewModel: groupPostsViewModel)
        groupPostsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        let tabBarList = [groupDetailViewController, groupMembersViewController, groupPostsViewController]
        
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

