//
//  AddGroupViewController.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController , AddGroupViewModelDelegate{
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var titleGroup: UITextField!
    @IBOutlet weak var departurePlace: UITextField!
    @IBOutlet weak var descriptionGroup: UITextView!
    @IBOutlet weak var departureDate: UITextField!
    @IBOutlet weak var arrivalDate: UITextField!
    
    let datePickerDeparture = UIDatePicker()
    let datePickerArrival = UIDatePicker()
    
    var dateDeparture : Date?
    var dateArrival : Date?
    
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
        addDatePikerListener()
       // self.scrollview.keyboardDismissMode
    }
    
    func addNavigationItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddGroup))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addNewGroup))
    }
    
    func addDatePikerListener() {
        self.departureDate.addDatePicker(datePicker: datePickerDeparture)
        self.arrivalDate.addDatePicker(datePicker: datePickerArrival)
        
        self.datePickerDeparture.addTarget(self, action: #selector(datePickerDepartureValueChanged), for: .valueChanged)
        self.datePickerArrival.addTarget(self, action: #selector(datePickerArrivalValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerDepartureValueChanged(sender:UIDatePicker) {
        self.dateDeparture = sender.date
        self.departureDate.text = getDateFormat().string(from: sender.date)
    }
    
    @objc func datePickerArrivalValueChanged(sender:UIDatePicker) {
        self.dateArrival = sender.date
        self.arrivalDate.text = getDateFormat().string(from: sender.date)
    }
    
    func getDateFormat() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }
    
    @objc func cancelAddGroup()
    {
        self.viewModel?.dimissAddGroupPage()
    }
    
    @objc func addNewGroup()
    {
        if isValidForm(){
            self.viewModel?.addGroup(groupToAdd: Group(self.titleGroup.text!, self.descriptionGroup.text, self.departurePlace.text!, dateDeparture!, dateArrival!))
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
        
        if self.dateDeparture != nil{
            self.departureDate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            self.departureDate.backgroundColor =  #colorLiteral(red: 0.9513320327, green: 0.8564937711, blue: 0.8076108098, alpha: 1)
            isValid = false
        }
        
        if self.dateArrival != nil{
            self.arrivalDate.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }else{
            self.arrivalDate.backgroundColor =  #colorLiteral(red: 0.9513320327, green: 0.8564937711, blue: 0.8076108098, alpha: 1)
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
    
}

