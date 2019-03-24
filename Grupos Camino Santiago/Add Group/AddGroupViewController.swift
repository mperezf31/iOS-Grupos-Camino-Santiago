//
//  AddGroupViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController , AddGroupViewModelDelegate{
    
    @IBOutlet weak var titleGroup: UITextField!
    @IBOutlet weak var departurePlace: UITextField!
    @IBOutlet weak var descriptionGroup: UITextView!
    @IBOutlet weak var departureDate: UITextField!
    @IBOutlet weak var arrivalDate: UITextField!
    
    @IBAction func showDepartureDatePicker() {
        self.departureDate.showDatePicker()
    }
    
    @IBAction func showArrivalDatePicker() {
        self.arrivalDate.showDatePicker()
    }
    
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddGroup))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNewGroup))
        
    }
    
    @objc func cancelAddGroup()
    {
        self.viewModel?.dimissAddGroupPage()
    }
    
    @objc func addNewGroup()
    {
        if isValidForm(){
            self.viewModel?.addGroup(groupToAdd: Group(self.titleGroup.text!, self.descriptionGroup.text, self.departurePlace.text!, Date(), Date()))
        }
        
    }
    
    func isValidForm() -> Bool {
        var isValid = true
        
        if let title =  self.titleGroup.text, !title.isEmpty{
            self.titleGroup.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            self.titleGroup.backgroundColor = #colorLiteral(red: 0.9513320327, green: 0.8564937711, blue: 0.8076108098, alpha: 1)
            isValid = false
        }
        
        if let departurePlace =  self.departurePlace.text, !departurePlace.isEmpty{
            self.departurePlace.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            self.departurePlace.backgroundColor =  #colorLiteral(red: 0.9513320327, green: 0.8564937711, blue: 0.8076108098, alpha: 1)
            isValid = false
        }
        
        if let descriptionGroup =  self.descriptionGroup.text, !descriptionGroup.isEmpty{
            self.descriptionGroup.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            self.descriptionGroup.backgroundColor =  #colorLiteral(red: 0.9513320327, green: 0.8564937711, blue: 0.8076108098, alpha: 1)
            isValid = false
        }
        
        return isValid
        
    }
    
    func error(_: AddGroupViewModel, errorMsg: String) {
        let uiAlertController = UIAlertController(title: "Error", message:errorMsg,preferredStyle: .alert)
        let uiAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        uiAlertController.addAction(uiAction)
        present(uiAlertController, animated: true, completion: nil)
    }
    
    /*
     func prepareDatePicker(dataPicker: UIDatePicker){
     
     //Formate Date
     dataPicker.datePickerMode = .date
     
     //ToolBar
     let toolbar = UIToolbar();
     toolbar.sizeToFit()
     let doneButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(donedatePicker));
     let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
     let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(cancelDatePicker));
     
     toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
     self.departureDate.inputAccessoryView = toolbar
     self.departureDate.inputView = dataPicker
     }
     
     @objc func donedatePicker(){
     let formatter = DateFormatter()
     formatter.dateFormat = "dd/MM/yyyy"
     //self.departureDate.text = formatter.string(from: dataPicker.date)
     self.view.endEditing(true)
     }
     
     @objc func cancelDatePicker(){
     self.view.endEditing(true)
     }
     
     */
}

