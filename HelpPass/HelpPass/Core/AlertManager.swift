//
//  AlertManager.swift
//  HelpPass
//
//  Created by Ly Truong H. VN.Danang on 16/06/2023.
//

import UIKit

class AlertManager {
    
    static func createOKAlert(title: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default)
        alert.addAction(actionOK)
        return alert
    }
    
    static func createOKCancelAlert(title: String, message: String, OKHandler: @escaping () -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) { _ in
            OKHandler()
        }
        let actionCancel = UIAlertAction(title: "Cancel".localized(), style: .cancel)
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        return alert
    }
}
