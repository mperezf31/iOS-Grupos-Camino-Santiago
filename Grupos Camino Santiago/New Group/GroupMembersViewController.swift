//
//  GroupMembersViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupMembersViewController: UIViewController, GroupMembersViewModelViewModelDelegate {
  
    private let viewModel: GroupMembersViewModel
    
    init(viewModel: GroupMembersViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupMembersViewModel(groupId: 0, groupsRepository: GroupsRepository()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getGroupMembers()
    }
    
    
    func groupMembersRetrieved(_: GroupMembersViewModel, group: [User]) {
        
        print("item members mostrar")
    }
    
    func error(_: GroupMembersViewModel, errorMsg: String) {
        print("error members")
    }
    
}
