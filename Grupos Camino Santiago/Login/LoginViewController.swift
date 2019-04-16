//
//  LoginViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 06/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import Eureka
import MaterialComponents.MaterialSnackbar
import JGProgressHUD

class LoginViewController: FormViewController , LoginViewModelDelegate{
    
    
    private var viewModel: LoginViewModel?
    private let hud = JGProgressHUD(style: .dark)
    
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
        
        title = "Grupos Camino de Santiago"
        navigationItem.backBarButtonItem = UIBarButtonItem()
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "PickledBluewoodLight")
        createForm()
    }
    
    
    func createForm(){
        form +++ Section(){ section in
                section.header =  HeaderFooterView<FormHeader>(.nibFile(name: "FormHeader", bundle: nil))
            }
            
            <<< EmailRow("Email"){ row in
                row.title = "Email"
                row.placeholder = "ejemplo@icloud.com"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< PasswordRow("Password"){ row in
                row.title = "Contraseña"
                row.cell.backgroundColor =  UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    
            }
            
            <<< ButtonRow(){ row in
                row.title = "Acceder"
                row.cell.backgroundColor = UIColor(named: "RoyalBlue")
                row.cell.tintColor = UIColor(named: "White")
                let bgColorView = UIView()
                bgColorView.backgroundColor =  UIColor(named: "RoyalBlueDark")
                row.cell.selectedBackgroundView = bgColorView
                
                }.onCellSelection({ (_, _) in
                    self.onClickLogin()
                })
            
            <<< ButtonRow(){ row in
                row.title = "Crear cuenta"
                row.cell.textLabel?.font = .systemFont(ofSize: 13)
                row.cell.backgroundColor = UIColor(named: "PickledBluewoodLight")
                row.cell.tintColor = UIColor(named: "White")
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor(named: "PickledBluewood")
                row.cell.selectedBackgroundView = bgColorView
                }.onCellSelection({ (_, _) in
                    self.viewModel?.goToRegister()
                })
        
    }
    
    
    func onClickLogin() {
        if self.form.validate().count == 0 && !hud.isVisible{
            let formValues = form.values()
            self.viewModel?.loginClick(email: formValues["Email"] as! String, password:  formValues["Password"] as! String)
        }
    }
    
    
    func showIndicator(_: LoginViewModel, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    func hideIndicator(_: LoginViewModel) {
        hud.dismiss()
    }
    
    func error(_: LoginViewModel, errorMsg: String) {
        let message = MDCSnackbarMessage()
        message.text = errorMsg
        MDCSnackbarManager.show(message)
    }
    
    
}
