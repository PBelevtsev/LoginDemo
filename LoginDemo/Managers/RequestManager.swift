//
//  RequestManager.swift
//  LoginDemo
//
//  Created by Pavel Belevtsev on 2/19/19.
//  Copyright © 2019 Pavel Belevtsev. All rights reserved.
//

import UIKit
import AFNetworking

class RequestManager: NSObject {
    
    static let shared = RequestManager(baseURL: "http://client.demo.crassu.la/api/")
    
    let baseURL: String
    let manager = AFHTTPSessionManager()
    
    init(baseURL: String) {
        self.baseURL = baseURL
        
        manager.requestSerializer = AFJSONRequestSerializer();
        manager.responseSerializer = AFJSONResponseSerializer();
    }

    func checkEmail(_ email : String!, _ completionHandler: @escaping (_ isValid: Bool, _ error: Error?) -> ()) {
        
        let escapedEmail = email.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let url = "\(baseURL)public/is-email-valid/\(escapedEmail!)"
        
        manager.get(url, parameters: nil, progress: { (progress) in
            
        }, success: { (operation, responseObject) in
            print("\(responseObject.debugDescription)")
            completionHandler(true, nil)
        }) { (operation, error) in
            completionHandler(false, error)
        }
        
    }
    
    func signIn(_ email : String!, _ password : String!, _ completionHandler: @escaping (_ isValid: Bool, _ error: Error?) -> ()) {
        
        let url = "\(baseURL)public/authenticate"
        let data = [
            "username": email,
            "password": password
        ]
        manager.post(url, parameters: data, progress: { (progress) in
            
        }, success: { (operation, responseObject) in
            print("\(responseObject.debugDescription)")
            completionHandler(true, nil)
        }) { (operation, error) in
            completionHandler(false, error)
        }
        
    }
    
}
