//
//  GroupPostsViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupPostsViewController: UIViewController , GroupPostsViewModelViewModelDelegate {
    
    private let viewModel: GroupPostsViewModel
    
    init(viewModel: GroupPostsViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupPostsViewModel(groupId: 0, groupsRepository: GroupsRepository()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getGroupPosts()
    }
    
    
    func grouPostsRetrieved(_: GroupPostsViewModel, posts: [Post]) {
        print("GroupPostsViewController")
    }
    
    func error(_: GroupPostsViewModel, errorMsg: String) {
        print("GroupPostsViewController")
    }
    

}
