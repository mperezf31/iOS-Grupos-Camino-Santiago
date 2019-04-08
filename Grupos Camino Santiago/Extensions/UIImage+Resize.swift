//
//  UIImage+Scale.swift
//  Grupos Camino Santiago
//
//  Created by Miguel Perez on 08/04/2019.
//  Copyright © 2019 Miguel Pérez. All rights reserved.
//

import UIKit

extension UIImage {
    
    
    func resizeImage(width: Int) -> UIImage? {
        
        let height = (self.size.height * CGFloat(width)) / self.size.width
        return resizeImage(targetSize: CGSize(width: CGFloat(width), height: CGFloat(height)))
    }
    
    func resizeImage(targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}
