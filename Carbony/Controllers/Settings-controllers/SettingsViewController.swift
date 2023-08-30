//
//  SettingsViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 17/08/23.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLogoutButton()
    }

    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func setupLogoutButton() {
        logoutButton.layer.cornerRadius = 8
    }

    @IBAction func logoutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavigationController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavigationController)
    }
}
