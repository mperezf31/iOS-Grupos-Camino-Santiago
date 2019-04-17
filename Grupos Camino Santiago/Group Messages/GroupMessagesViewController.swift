//
//  GroupPostsViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import MessengerKit


class GroupMessagesViewController: UIViewController, GroupPostsViewModelViewModelDelegate {

    
    private let viewModel: GroupMessagesViewModel
    
    init(viewModel: GroupMessagesViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupMessagesViewModel(groupId: 0, groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.viewModel.getGroupPosts()
        
    }
    
    
    func grouPostsRetrieved(_: GroupMessagesViewModel, posts: [Post]) {
        print("Chats recuperados")
    }
    
    func error(_: GroupMessagesViewModel, errorMsg: String) {
        print("Error al recuperar chats")
    }
    
}
