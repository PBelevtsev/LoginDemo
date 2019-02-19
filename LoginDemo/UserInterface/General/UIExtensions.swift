//
//  UIExtensions.swift
//  LoginDemo
//
//  Created by Pavel Belevtsev on 2/19/19.
//  Copyright © 2019 Pavel Belevtsev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func colorRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return colorRGB(red, green, blue, alpha: 1.0)
    }
    
    static func colorRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha : CGFloat) -> UIColor {
        
        return UIColor.init(red: red / 255.0,
                            green: green / 255.0,
                            blue: blue / 255.0, alpha: alpha)
        
    }
    
    static func colorRGB(_ hexValue : String) -> UIColor {
        return UIColor.colorRGB(hexValue, alpha : 1.0)
    }
    
    static func colorRGB(_ hexValue : String, alpha : CGFloat) -> UIColor {
        
        if let colorNum = UInt(String(hexValue.suffix(6)), radix: 16) {
            let red = colorNum >> 16
            let green = (colorNum & 0x00FF00) >> 8
            let blue = (colorNum & 0x0000FF)
            return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
            
        }
        return .black
    }
    
}

extension UIView {
    
    func roundCorners()
    {
        roundCorners(with: self.frame.size.height / 2.0)
    }
    
    func roundCorners(with radius: CGFloat)
    {
        self.layer.cornerRadius = radius
    }
    
}

extension UIButton {
    
    func makeRounded()
    {
        self.roundCorners(with: 8.0)
        self.layer.shadowColor = UIColor.black.cgColor;
        self.layer.shadowOffset = CGSize.init(width: 0.0, height: 2.0);
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowRadius = 2.0;
    }
    
}

