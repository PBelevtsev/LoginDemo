//
//  LoginDataSource.swift
//  LoginDemo
//
//  Created by Pavel Belevtsev on 2/19/19.
//  Copyright © 2019 Pavel Belevtsev. All rights reserved.
//

import UIKit

protocol LoginDataSourceDelegate: class {
    func loginDataIsFilled(_ filled: Bool)
}

class LoginDataSource: NSObject {

    weak var delegate: LoginDataSourceDelegate?
    
    var params = [
        "username": "",
        "password": ""
    ]
    
    func updateData(_ param: String!, _ value: String!) {
        params[param] = value;

        if delegate != nil {
            delegate?.loginDataIsFilled((params["username"]!.count > 0) && (params["password"]!.count > 0))
        }
    }
    
}
