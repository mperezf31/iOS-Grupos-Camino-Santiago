//
//  UITextField+DatePicker.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addDatePicker(datePicker: UIDatePicker) {
        datePicker.datePickerMode = .date
        datePicker.locale = Locale.init(identifier: "es")
        self.inputView = datePicker
      /*
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([spaceButton, cancelButton], animated: false)
        self.inputAccessoryView = toolbar
 */
    }
    
    @objc func cancelDatePicker(){
        self.endEditing(true)
    }
    
}
