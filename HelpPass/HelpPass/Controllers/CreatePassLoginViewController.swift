//
//  CreatePassLoginViewController.swift
//  HelpPass
//
//  Created by Ly Truong H. VN.Danang on 16/06/2023.
//

import UIKit
import CryptoKit

class CreatePassLoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var passRepeatTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    @IBAction func ok(_ sender: Any) {
        guard let firstText = self.passTextField.text else { return }
        guard let secondText = self.passRepeatTextField.text else { return }
        
        guard firstText.count >= 12 && secondText.count >= 12 else {
            
            let alert = AlertManager.createOKAlert(title: "Passphrase must be 12 characters or more".localized())
            self.present(alert, animated: true)
            return
        }
        
        guard firstText == secondText else {
            
            let alert = AlertManager.createOKAlert(title: "Passphrases do not match".localized())
            self.present(alert, animated: true)
            return
        }
        
        let data = Data(firstText.utf8)
        let hash = SHA256.hash(data: data)
        let hashString = hash.compactMap { String(format: "%02x", $0) }.joined()
        let bytes = hashString.hexaBytes.map({ Int8(bitPattern: $0) })
        
        DataStoreManager.kuznyechik = Kuznyechik(key: bytes)
        UserDefaults.standard.set(true, forKey: "isPassphraseSet")
        UserDefaults.standard.set(DataStoreManager.kuznyechik?.encrypt(string: "Kuznyechik"), forKey: "checkPhrase")
        
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
//    button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupUI() {
        passTextField.delegate = self
        passTextField.placeholder = "enter password"
        passTextField.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        passTextField.layer.borderColor = Color.Calendar.fourthBorderLevelScore?.cgColor
        passTextField.layer.borderWidth = 2
        passTextField.layer.cornerRadius = 12
        passTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passTextField.frame.height))
        passTextField.leftViewMode = .always
        passTextField.autocorrectionType = .no
        passTextField.textContentType = .oneTimeCode
        passTextField.returnKeyType = .done
        passTextField.isSecureTextEntry = true
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        passRepeatTextField.delegate = self
        passRepeatTextField.placeholder = "repeat password"
        passRepeatTextField.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        passRepeatTextField.layer.borderColor = Color.Calendar.fourthBorderLevelScore?.cgColor
        passRepeatTextField.layer.borderWidth = 2
        passRepeatTextField.layer.cornerRadius = 12
        passRepeatTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passRepeatTextField.frame.height))
        passRepeatTextField.leftViewMode = .always
        passRepeatTextField.autocorrectionType = .no
        passRepeatTextField.textContentType = .oneTimeCode
        passRepeatTextField.returnKeyType = .done
        passRepeatTextField.isSecureTextEntry = true
        passRepeatTextField.translatesAutoresizingMaskIntoConstraints = false
    }
}
