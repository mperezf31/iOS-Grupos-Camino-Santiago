//
//  RegisterViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 07/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import Eureka
import MaterialComponents.MaterialSnackbar
import JGProgressHUD

class RegisterViewController: FormViewController, RegisterViewModelDelegate{
    
    private var viewModel: RegisterViewModel?
    private let hud = JGProgressHUD(style: .dark)

    init(viewModel: RegisterViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: RegisterViewModel(groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Crear cuenta"

        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(named: "PickledBluewood")
        createForm()
    }
    
    
    func createForm(){
        form +++ Section(){ section in
                section.header =  HeaderFooterView<FormHeader>(.nibFile(name: "FormHeader", bundle: nil))
            }
            
            <<< ImageRow("photo"){ row in
                row.title = "Avatar"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                }.cellUpdate { cell, row in
                    cell.accessoryView?.layer.cornerRadius = 17
                    cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
                }
            
            <<< NameRow("name"){ row in
                row.title = "Nombre"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< EmailRow("email"){ row in
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
            
            <<< PasswordRow("password"){ row in
                row.title = "Contraseña"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    
            }
            
            <<< PasswordRow("confirmPassword"){ row in
                row.title = "Confirmar contraseña"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    
            }
            
            <<< ButtonRow(){ row in
                row.title = "Crear cuenta"
                row.cell.backgroundColor = UIColor(named: "RoyalBlue")
                row.cell.tintColor = UIColor(named: "White")
                let bgColorView = UIView()
                bgColorView.backgroundColor =  UIColor(named: "RoyalBlueDark")
                row.cell.selectedBackgroundView = bgColorView
                
                }.onCellSelection({ (_, _) in
                    self.onClickRegister()
                })
        
    }
    
    func onClickRegister(){

        
        let formErrors = form.validate()
        
        if(formErrors.count == 0){
            let formValues = form.values()
            let pass = formValues["password"] as? String
            let confirmPass = formValues["confirmPassword"] as? String
            
            if(pass == confirmPass){
                var photo = form.values()["photo"] as? UIImage
                
                if let image = photo{
                    photo = image.resizeImage(width: 100)
                }
                
                let photoBase64 = photo?.jpegData(compressionQuality: 1.0)!.base64EncodedString()
                
                let user = User()
                user.photo =  photoBase64
                user.name = formValues["name"] as? String
                user.email = formValues["email"] as? String
                user.password = pass
                viewModel?.registerClick(user: user)
            }else{
                let message = MDCSnackbarMessage()
                message.text = "Las contraseñas no coinciden"
                MDCSnackbarManager.show(message)
            }
            
        }
    
    }
    

    
    func showIndicator(_: RegisterViewModel, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    func hideIndicator(_: RegisterViewModel) {
        hud.dismiss()
    }
    
    func error(_: RegisterViewModel, errorMsg: String) {
        let message = MDCSnackbarMessage()
        message.text = errorMsg
        MDCSnackbarManager.show(message)
    }

}
