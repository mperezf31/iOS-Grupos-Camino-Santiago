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
    @IBOutlet weak var departureDate: UILabel!
    @IBOutlet weak var arrivalDate: UILabel!
    
    private var viewModel: AddGroupViewModel?
    private let datePicker = UIDatePicker()
    
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
        
        self.departureDate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDepartureDatePicker)))
        self.arrivalDate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showArrivalDatePicker)))
    }
    
    @objc func showDepartureDatePicker(sender:UITapGestureRecognizer) {
        
    }
    
    @objc func showArrivalDatePicker(sender:UITapGestureRecognizer) {
        
        print("tap working")
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
    
    
    
}
