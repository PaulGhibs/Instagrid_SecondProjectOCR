//
//  Extensions.swift
//  P4_01_Xcode
//
//  Created by Paul Ghibeaux on 20/05/2021.
//

import UIKit


extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
}


extension ViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    

}
