//
//  LoginViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 06/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController , LoginViewModelDelegate{


    private var viewModel: LoginViewModel?
    
    
    init(viewModel: LoginViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: LoginViewModel(groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    func error(_: LoginViewModel, errorMsg: String) {
        
    }
    

}
