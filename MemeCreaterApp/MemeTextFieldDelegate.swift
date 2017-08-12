//
//  MemeTextFieldDelegate.swift
//  MemeCreaterApp
//
//  Created by Vasantha kumar Vijaya kumar on 8/12/17.
//  Copyright © 2017 Vasantha kumar. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UITextFieldDelegate {
    
    // Delegate functions for Text field delegate
 
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            if textField.restorationIdentifier == "TOP" {
                textField.text = "TOP"
            }
            
            if textField.restorationIdentifier == "BOTTOM" {
                textField.text = "BOTTOM"
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
