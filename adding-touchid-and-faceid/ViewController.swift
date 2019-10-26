//
//  ViewController.swift
//  adding-touchid-and-faceid
//
//  Created by Declan on 25/10/2019.
//  Copyright © 2019 Declan. All rights reserved.
//

//Please note: Privacy - Face ID Usage Description also added in info.plist

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signedInLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        signedInLabel.isHidden = true
    }


    @IBAction func signInButtonTapped(_ sender: Any) {
                
        let context = LAContext()
        
        var error: NSError?
        
        //Check if the device support authentication biometrics
        if(context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)) {
            
            //This message is only shown to users with touch ID
            let reason = "Identify yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
            
            DispatchQueue.main.async {
                    if success{
                        print("Success - Unlocked")
                        self?.signInButton.isHidden = true
                        self?.signedInLabel.isHidden = false
                    } else {
                        //i.e issue with being authenticated
                        print("Error - Locked")
                        
                        //Show alert error
                        let ac = UIAlertController(title: "Authentication Failed", message: "You could not be verified; please try again.", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                        self?.present(ac, animated: true)
                        
                    }
                }
            }
        } else {
            //No biometrics
            
            //Show alert error
            let ac = UIAlertController(title: "Biometrics Unavailable", message: "Your device is not configured for biometric authentication", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
            
        }
    }

}
