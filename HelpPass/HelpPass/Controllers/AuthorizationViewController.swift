//
//  AuthorizationViewController.swift
//  HelpPass
//
//  Created by Ly Truong H. VN.Danang on 16/06/2023.
//

import UIKit
import LocalAuthentication

class AuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        login()
    }
    
    private func login() {
        
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Please login with Local Authentication"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
//                        self?.againButton.isHidden = false
                        return
                    }
                    
                    let isPassphraseSet = false
                    
                    if isPassphraseSet {
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(EnterPassLoginViewController())
                    } else {
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(CreatePassLoginViewController())
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .cancel)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }

}
