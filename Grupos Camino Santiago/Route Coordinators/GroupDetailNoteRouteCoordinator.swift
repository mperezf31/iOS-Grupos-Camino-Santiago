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
        
    var rootViewController: UIViewController
    {
        get
        {
            return navigationController
        }
    }
    
    private let navigationController: UITabBarController
    
    private let groupsStorage: GroupsStorage
    
    init(groupoId: Int, groupsStorage: GroupsStorage)
    {
        self.groupsStorage = groupsStorage
   
        //Item detail
        let groupDetailViewModel = GroupDetailViewModel(groupId: groupoId, groupsStorage: groupsStorage)
        let groupDetailViewController = GroupDetailViewController(viewModel: groupDetailViewModel)
        groupDetailViewController.tabBarItem =  UITabBarItem(title: "Detalle", image: UIImage(named: "TabDetail"), tag: 1)

        
        //Item members
        let groupMembersViewModel = GroupMembersViewModel(groupId: groupoId, groupsStorage: groupsStorage)
        let groupMembersViewController = GroupMembersViewController(viewModel: groupMembersViewModel)
        groupMembersViewController.tabBarItem =  UITabBarItem(title: "Miembros", image: UIImage(named: "TabMembers"), tag: 1)

        //Group posts
        let groupPostsViewModel = GroupMessagesViewModel(groupId: groupoId, groupsStorage: groupsStorage)
        let groupPostsViewController = GroupMessagesViewController(viewModel: groupPostsViewModel)
        groupPostsViewController.tabBarItem =  UITabBarItem(title: "Mensajes", image: UIImage(named: "TabPosts"), tag: 1)
        
        
        let tabBarList = [groupDetailViewController, groupMembersViewController, groupPostsViewController]
        
        self.navigationController = UITabBarController()
        self.navigationController.setViewControllers(tabBarList, animated: true)
    }
    
}

