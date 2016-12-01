//
//  ViewController.swift
//  PicMoodShare
//
//  Created by Evgeny Shkuratov on 11/28/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("EVGY: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("EVGY: User cancelled authentication")
            } else {
                print("EVGY: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("EVGY: Unable to authenticate with Firebase - \(error)")
            } else {
                print("EVGY: Successfully authenticated with Firebase")
            }
        })
    }
    
    
    
}

