//
//  UITextField+DatePicker.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 24/03/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

extension UITextField {
    
    func showDatePicker() {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = .date
        datePickerView.locale = Locale.init(identifier: "es")
        self.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerDepartureValueChanged), for: .valueChanged)
    }
    
    @objc func datePickerDepartureValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.text = dateFormatter.string(from: sender.date)
    }
    
}
