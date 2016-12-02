//
//  FeedVC.swift
//  PicMoodShare
//
//  Created by Evgeny Shkuratov on 12/1/16.
//  Copyright © 2016 Evgeny Shkuratov. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        let _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("EVGY: Signed out")
        dismiss(animated: true, completion: nil)
    }

    
}
