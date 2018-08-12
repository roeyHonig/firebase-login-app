//
//  WelcomeScreenViewController.swift
//  firebase-login-app
//
//  Created by hackeru on 1 Elul 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class WelcomeScreenViewController: UIViewController {

    var handle: AuthStateDidChangeListenerHandle?
    @IBOutlet var displayName: UILabel!
    
    @IBAction func returnToLogin(_ sender: UIButton) {
        // performSegue(withIdentifier: "goBackToLogin", sender: sender)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // performs a cheack regarding the ststus of a user (signed in or not)
            // also listens to changes in status
            if user == nil {
                // No user is signed in -> go to loginScreen
                self.performSegue(withIdentifier: "goBackToLogin", sender: self)
            } else {
                // init the displayName Label
                self.displayName.text = user?.displayName
            }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
