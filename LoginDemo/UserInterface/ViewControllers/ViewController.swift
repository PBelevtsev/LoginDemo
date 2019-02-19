//
//  ViewController.swift
//  LoginDemo
//
//  Created by Pavel Belevtsev on 2/19/19.
//  Copyright © 2019 Pavel Belevtsev. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UIGestureRecognizerDelegate, LoginDataSourceDelegate {

    @IBOutlet weak var constraintTitleTop: NSLayoutConstraint!
    @IBOutlet weak var constraintTitleBottom: NSLayoutConstraint!
    
    @IBOutlet weak var viewEmail: LoginEditView!
    @IBOutlet weak var viewPassword: LoginEditView!
    @IBOutlet weak var buttonVisible: UIButton!
    
    @IBOutlet weak var buttonSignIn: UIButton!
    @IBOutlet weak var constraintKeyboard: NSLayoutConstraint!
    
    @IBOutlet weak var loginDataSource: LoginDataSource!
    
    var isResized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonSignIn.makeRounded()
        
        let tapKeyboard = UITapGestureRecognizer.init(target: self, action: #selector(closeKeyboard))
        tapKeyboard.cancelsTouchesInView = false
        tapKeyboard.delegate = self;
        self.view.addGestureRecognizer(tapKeyboard)
        
        loginDataSource.delegate = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.closeKeyboard()
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if (!self.isResized) {
            self.isResized = true
            
            if (self.view.frame.size.height <= 568.0) {
                self.constraintTitleTop.constant = 44.0;
                self.constraintTitleBottom.constant = 0.0;
                self.view.layoutIfNeeded()
            }
        }
        
    }
    
    // Mark: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is UIControl)
    }
    
    // MARK: - Keyboard
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
        
    }
    
    
    @objc func keyboardWillShow(_ notification : NSNotification) {
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.updateKeyboardHeight(targetFrame.size.height);
    }
    
    @objc func keyboardWillHide(_ notification : NSNotification) {
        self.updateKeyboardHeight(0.0);
    }
    
    func updateKeyboardHeight(_ height : CGFloat) {

        var keyboardHeight = height;
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.keyWindow {
                keyboardHeight -= window.safeAreaInsets.bottom
            }
        }
        keyboardHeight = max(keyboardHeight, 0)
        
        if (keyboardHeight != constraintKeyboard.constant) {
            constraintKeyboard.constant = keyboardHeight;
            self.view.layoutIfNeeded()
        }
    
    }
    
    // MARK: - LoginDataSourceDelegate
    
    func loginDataIsFilled(_ filled: Bool) {
        
        if (self.buttonSignIn.isUserInteractionEnabled != filled) {
            self.buttonSignIn.isUserInteractionEnabled = filled
            self.buttonSignIn.backgroundColor = filled ? .black : UIColor.colorRGB("C9C9CC")
        }
        
    }
    
    // MARK: - Actions
    
    @IBAction func buttonCrossPressed(_ sender: UIButton) {
        self.closeKeyboard()
    }
    
    @IBAction func buttonForgotPressed(_ sender: UIButton) {
        self.closeKeyboard()
    }

    @IBAction func buttonVisiblePressed(_ sender: UIButton) {
        let textField = viewPassword.textFieldData!
        
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false;
            buttonVisible.setImage(UIImage.init(named: "ic_visibility"), for: .normal)
        } else {
            let text = textField.text ?? ""
            textField.isSecureTextEntry = true;
            buttonVisible.setImage(UIImage.init(named: "ic_visibility_off"), for: .normal)
            textField.deleteBackward()
            textField.insertText(text)
        }
        
    }
    
    @IBAction func buttonSignInPressed(_ sender: UIButton) {
        self.closeKeyboard()
        
        SVProgressHUD.show()

        RequestManager.shared.signIn(viewEmail.textFieldData.text, viewPassword.textFieldData.text) { (isValid, error) in
            SVProgressHUD.dismiss()
            
            if error != nil {
                self.showMessageAlert(error?.localizedDescription, {
                    
                })
            } else {
                self.showMessageAlert("Success!!!", {
                    
                })
            }
        }
        
    }
    
    func showMessageAlert(_ message: String?, _ completion: @escaping ()->()) {
        if message != nil {
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                completion()
            }))
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
}

