//
//  LoginEditView.swift
//  LoginDemo
//
//  Created by Pavel Belevtsev on 2/19/19.
//  Copyright © 2019 Pavel Belevtsev. All rights reserved.
//

import UIKit

class LoginEditView: UIView, UITextFieldDelegate {

    @IBInspectable var paramName: String?
        
    @IBOutlet weak var labelPlaceholder: UILabel!
    @IBOutlet weak var constraintPlaceholder: NSLayoutConstraint!
    @IBOutlet weak var textFieldData: UITextField!
    @IBOutlet weak var viewDivider: UIView!

    @IBOutlet weak var loginDataSource: LoginDataSource!
    
    let placeholderColor = [UIColor.black, UIColor.colorRGB("5F5555")]
    let placeholderConstraint = [44.0, 20.0]
    let placeholderFontSize = [16.0, 12.0]
    let dividerAlpha = [0.12, 0.87]
    
    func updateUI(_ placeholderIsActive : Bool, _ dividerIsActive : Bool) {
        
        let placeholderIndex = placeholderIsActive ? 1 : 0;
        let dividerIndex = dividerIsActive ? 1 : 0;
        
        constraintPlaceholder.constant = CGFloat(placeholderConstraint[placeholderIndex]);
        
        UIView.animate(withDuration: 0.2) {
            self.labelPlaceholder.textColor = self.placeholderColor[placeholderIndex];
            self.labelPlaceholder.font = UIFont.systemFont(ofSize: CGFloat(self.placeholderFontSize[placeholderIndex]))
            self.viewDivider.alpha = CGFloat(self.dividerAlpha[dividerIndex]);
            
            self.layoutIfNeeded()
        }
        
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.updateUI(true, true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        loginDataSource.updateData(paramName, newText)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        self.updateUI((text.count > 0), false)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
    
        loginDataSource.updateData(paramName, "")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    
    }
    
}
