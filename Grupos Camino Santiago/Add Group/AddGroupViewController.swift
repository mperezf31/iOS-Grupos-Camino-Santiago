//
//  AddGroupViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
import Eureka
import MapKit
import JGProgressHUD


class AddGroupViewController: FormViewController , AddGroupViewModelDelegate {
    
    private let hud = JGProgressHUD(style: .dark)

    private var viewModel: AddGroupViewModel?
    
    init(viewModel: AddGroupViewModel)
    {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel?.delegate = self
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(viewModel: AddGroupViewModel(groupsStorage: GroupsStorage(baseUrl: "")))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crear grupo"
        
        addNavigationItems()
        
        tableView.backgroundColor = UIColor(named: "SilverChalice")
        createForm()
    }
    
    func addNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddGroup))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNewGroup))
    }
    
    
    @objc func cancelAddGroup()
    {
        self.viewModel?.dimissAddGroupPage()
    }
    
    @objc func addNewGroup()
    {
        
        let formErrors = form.validate()
        
        if(formErrors.count == 0){
            let formValues = form.values()
            let departureDate = formValues["DepartureDate"] as! Date
            let arrivalDate = formValues["ArrivalDate"] as! Date
            
            if arrivalDate > departureDate {
                var photo = form.values()["Photo"] as? UIImage
                
                if let image = photo{
                    photo = image.resizeImage(width: 100)
                }
                                
                let group = Group()
                group.photo =  photo?.toBase64()
                group.title = formValues["Title"] as? String
                group.description = formValues["Description"] as? String
                group.departurePlace = formValues["DeparturePlace"] as? String
                group.latitude = (formValues["Place"] as? CLLocation)?.coordinate.latitude
                group.longitude = (formValues["Place"] as? CLLocation)?.coordinate.longitude
                group.departureDate = departureDate
                group.arrivalDate = arrivalDate

                self.viewModel?.addGroup(groupToAdd: group)

            }else{
                let message = MDCSnackbarMessage()
                message.text = "La fecha de llegada debe de ser posterior a la de salida"
                MDCSnackbarManager.show(message)
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as? UITableViewHeaderFooterView)?.textLabel?.textColor = UIColor(named: "White")
        (view as? UITableViewHeaderFooterView)?.textLabel?.textAlignment = .center
        (view as? UITableViewHeaderFooterView)?.backgroundView?.backgroundColor = UIColor(named: "SilverChalice")
        (view as? UITableViewHeaderFooterView)?.contentView.layoutMargins.top = 1
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func createForm(){
        form +++ Section(){ section in
            section.header =  HeaderFooterView<FormHeader>(.nibFile(name: "FormHeader", bundle: nil))
            }
            
            +++ Section("Datos generales")
            
            <<< ImageRow("Photo"){ row in
                row.title = "Imagen del grupo"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
            }
            
            <<< TextRow("Title"){ row in
                row.title = "Título"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
            }
            
            <<< TextAreaRow("Description"){ row in
                row.placeholder = "Descripción"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.placeholderLabel?.textColor = .red
                    }
            }
            
            +++ Section("Datos de salida")
            
            <<< TextRow("DeparturePlace"){ row in
                row.title = "Lugar de salida"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                    
            }
            
            <<< LocationRow("Place"){ row in
                row.title = "Localización"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.add(rule: RuleRequired())
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            
            <<< DateTimeRow("DepartureDate"){ row in
                row.title = "Fecha de salida"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.dateFormatter = self.getFormatter()
                row.minimumDate = Date()
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            
            +++ Section("Datos de llegada")
            
            <<< DateTimeRow("ArrivalDate"){ row in
                row.title = "Fecha de llegada"
                row.cell.backgroundColor = UIColor(named: "Silver")
                row.cell.tintColor = UIColor(named: "RoyalBlue")
                row.dateFormatter = self.getFormatter()
                row.minimumDate = Date()
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChangeAfterBlurred
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
                    
        }
        
    }
    
    func getFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        formatter.locale = Locale.init(identifier: "es")
        return formatter
    }
    
    func showIndicator(_: AddGroupViewModel, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: self.view)
    }
    
    func hideIndicator(_: AddGroupViewModel) {
        hud.dismiss()
    }
    
    func error(_: AddGroupViewModel, errorMsg: String) {
        let message = MDCSnackbarMessage()
        message.text = errorMsg
        MDCSnackbarManager.show(message)
    }
    
}

