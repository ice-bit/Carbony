//
//  RegisterViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/08/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterButton()
        setupCancelButton()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              !username.isEmpty,
              !password.isEmpty else {
                  showAlert(title: "Missing Credentials", message: "Give both Username and Password.")
                  return
              }
        
        // Store credentials
        defaults.set(password, forKey: username)
        print("Credentails added")
        showAlert(title: "Credentials added", message: "Please continue") { [weak self] in
            self?.dismiss(animated: true)
        }
        
    }
    
    private func setupCancelButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupRegisterButton() {
        registerButton.layer.cornerRadius = 8
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
//            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            
            
        }
    }

}
