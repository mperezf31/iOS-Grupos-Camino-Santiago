//
//  AddGroupViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController , AddGroupViewModelDelegate{

    private var viewModel: AddGroupViewModel?

    init(viewModel: AddGroupViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: AddGroupViewModel(groupsRepository: GroupsRepository()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear grupo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddGroup))
    }

    @objc func cancelAddGroup()
    {
        self.viewModel?.dimissAddGroupPage()
    }

    func addGroupViewModelSuccess(_: AddGroupViewModel) {
        
    }
    
    func error(_: AddGroupViewModel, errorMsg: String) {
        let uiAlertController = UIAlertController(title: "Error", message:errorMsg,preferredStyle: .alert)
        let uiAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        uiAlertController.addAction(uiAction)
        present(uiAlertController, animated: true, completion: nil)
    }
   
}
