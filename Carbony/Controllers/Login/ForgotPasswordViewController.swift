//
//  ForgotPasswordViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/08/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        setupResetPasswordButton()
    }
    
    @IBAction func resetPasswordTapped(_ sender: Any) {
        guard let username = usernameTextField.text,
              let newPassword = newPasswordTextField.text,
              !username.isEmpty,
              !newPassword.isEmpty else {
            showAlert(title: "Missing Credentials", message: "Please provide both username and password")
            return
        }

        if defaults.string(forKey: username) != nil {
            // Update the password for the user
            defaults.set(newPassword, forKey: username)
            showAlert(title: "Success", message: "Password changed successfully") { [weak self] in
                self?.dismiss(animated: true)
            }
        } else {
            showAlert(title: "Failed", message: "Failed to change the password")
        }
    }
    
    private func setupCancelButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func setupResetPasswordButton() {
        resetPasswordButton.layer.cornerRadius = 8
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
