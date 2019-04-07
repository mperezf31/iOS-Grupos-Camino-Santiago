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
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
        createForm()
    }
    
    
    func createForm(){
        form +++ Section(){ section in
            section.header = {
                return HeaderFooterView<UIView>(.callback({
                    return LoginHeader.instanceFromNib()
                }))
            }()
            }
            
            <<< EmailRow("email"){ row in
                row.title = "Email"
                row.placeholder = "ejemplo@icloud.com"
                row.cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                row.cell.tintColor = #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< PasswordRow("password"){ row in
                row.title = "Contraseña"
                row.cell.backgroundColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                row.cell.tintColor = #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    
            }
            
            <<< ButtonRow(){ row in
                row.title = "Login"
                row.cell.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.4588235294, blue: 0.8705882353, alpha: 1)
                row.cell.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                let bgColorView = UIView()
                bgColorView.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.3089947623, blue: 0.8705882353, alpha: 1)
                row.cell.selectedBackgroundView = bgColorView
                
                }.onCellSelection({ (_, _) in
                    self.onClickLogin()
                })
            
            <<< ButtonRow(){ row in
                row.title = "Crear cuenta"
                row.cell.textLabel?.font = .systemFont(ofSize: 13)
                row.cell.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2549019608, blue: 0.3490196078, alpha: 1)
                row.cell.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                let bgColorView = UIView()
                bgColorView.backgroundColor = #colorLiteral(red: 0.1843137255, green: 0.2220466526, blue: 0.3490196078, alpha: 1)
                row.cell.selectedBackgroundView = bgColorView
                }.onCellSelection({ (_, _) in
                    self.viewModel?.goToRegister()
                })
        
    }
    
    
    func onClickLogin() {
        if self.form.validate().count == 0 {
            let formValues = form.values()
            self.viewModel?.loginClick(email: formValues["email"] as! String, password:  formValues["password"] as! String)
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
