//
//  ViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/08/23.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    //var stackViewBottomConstraint: NSLayoutConstraint?
    var guestLabelBottomConstraint: NSLayoutConstraint?

    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*if UserDefaults.standard.bool(forKey: "isUserLoggedIn") {
            print(UserDefaults.standard.bool(forKey: "isUserLoggedIn"))
            if let summaryViewController = storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController {
                self.navigationController?.pushViewController(summaryViewController, animated: true)
            }
        } else {
            setupGuestLabel()
            setupAuthButton()
        }*/
        setupGuestLabel()
        setupAuthButton()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            // Update constraints based on new orientation
            //self?.updateConstraintsForOrientation(size: size)
            self?.updateConstraintsForGuestLabel(size: size)
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupAuthButton() {
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 8
        registerButton.layer.borderColor = UIColor(red: 0.118, green: 0.137, blue: 0.173, alpha: 1).cgColor
        
        loginButton.layer.cornerRadius = 8
    }
    
    let guestLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.208, green: 0.762, blue: 0.757, alpha: 1)
        label.textAlignment = .center
        label.attributedText = NSMutableAttributedString(string: "Continue as a guest", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private func setupGuestLabel() {
        view.addSubview(guestLabel)
        
        let initialGuestLabelBottomConstraint: CGFloat = view.frame.width > view.frame.height ? -20 : -50
        
        guestLabelBottomConstraint = guestLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: initialGuestLabelBottomConstraint)
        
        guestLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            guestLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guestLabelBottomConstraint!
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(guestLabelTapped))
        guestLabel.addGestureRecognizer(tapGesture)
        guestLabel.isUserInteractionEnabled = true
    }
    
    private func updateConstraintsForGuestLabel(size: CGSize) {
        if size.width > size.height {
            guestLabelBottomConstraint?.constant = -20
        } else {
            guestLabelBottomConstraint?.constant = -50
        }
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        print("Login button  tapped")
        if let loginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
//            let rootViewController = UINavigationController(rootViewController: loginViewController)
//            present(rootViewController, animated: true)
            navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        print("Sign up button tapped")
        if let registerViewController = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController {
            let rootViewController = UINavigationController(rootViewController: registerViewController)
            present(rootViewController, animated: true)
        }
    }
        
    @objc private func guestLabelTapped() {
        print("Guest label tapped")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
