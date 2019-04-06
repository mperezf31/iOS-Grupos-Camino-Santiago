//
//  LoginHeader.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 06/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

class LoginHeader: UIView {
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "LoginHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
