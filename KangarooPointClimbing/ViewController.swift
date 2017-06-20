//
//  ViewController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 23/5/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {

    let loginButton = LoginButton(readPermissions: [ .publicProfile ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.delegate = self
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        login()
    }
    
    func login() {
        if let accessToken = AccessToken.current {
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if error != nil {
                    print("failed to login")
                    return
                } else {
                    print("successfully logged in.")
                    self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                    
                }
            })
        }

    }

    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
    }
  
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
}

