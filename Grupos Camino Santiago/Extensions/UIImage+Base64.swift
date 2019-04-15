//
//  UIImage+Base64.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 15/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    public convenience init?(imageString: String){
        let data = Data(base64Encoded: imageString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        self.init(data: data)!
    }
    
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
   
}
