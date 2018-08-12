//
//  ViewController.swift
//  firebase-login-app
//
//  Created by hackeru on 1 Elul 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func showWelcomeScreen(_ sender: UIButton) {
        // performSegue(withIdentifier: "goToWelcomeScreen", sender: sender)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // performs a cheack regarding the ststus of a user (signed in or not)
            // also listens to changes in status
            if user != nil {
                // a user is signed in -> go to welcomeScreen
                self.performSegue(withIdentifier: "goToWelcomeScreen", sender: self)
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }


}

