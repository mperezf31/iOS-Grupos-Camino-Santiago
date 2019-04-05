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
    
    private let groupsRepository: GroupsStorage
    
    init(groupoId: Int, groupsRepository: GroupsStorage)
    {
        self.groupsRepository = groupsRepository
   
        //Item detail
        let groupDetailViewModel = GroupDetailViewModel(groupId: groupoId, groupsRepository: groupsRepository)
        let groupDetailViewController = GroupDetailViewController(viewModel: groupDetailViewModel)
        groupDetailViewController.tabBarItem =  UITabBarItem(title: "Detalle", image: UIImage(named: "TabDetail"), tag: 1)

        
        //Item members
        let groupMembersViewModel = GroupMembersViewModel(groupId: groupoId, groupsRepository: groupsRepository)
        let groupMembersViewController = GroupMembersViewController(viewModel: groupMembersViewModel)
        groupMembersViewController.tabBarItem =  UITabBarItem(title: "Miembros", image: UIImage(named: "TabMembers"), tag: 1)

        //Group posts
        let groupPostsViewModel = GroupPostsViewModel(groupId: groupoId, groupsRepository: groupsRepository)
        let groupPostsViewController = GroupPostsViewController(viewModel: groupPostsViewModel)
        groupPostsViewController.tabBarItem =  UITabBarItem(title: "Chat", image: UIImage(named: "TabPosts"), tag: 1)
        
        
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

