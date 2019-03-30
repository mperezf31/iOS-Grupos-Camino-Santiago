//
//  GroupDetailViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 30/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController , GroupDetailViewModelDelegate{
   
    
    private let viewModel: GroupDetailViewModel

    init(viewModel: GroupDetailViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: GroupDetailViewModel(groupId: 0, groupsRepository: GroupsRepository()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        self.viewModel.getGroupDetail()
    }
    
    
    func groupDetailRetrieved(_: GroupDetailViewModel, group: Group) {
        print("GroupDetailViewController")

    }
    
    func error(_: GroupDetailViewModel, errorMsg: String) {
        print("GroupDetailViewController")
    }
    
}
