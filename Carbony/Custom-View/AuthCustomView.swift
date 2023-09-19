//
//  AuthCustomView.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/08/23.
//

import UIKit

class AuthCustomView: UIView {
    
    let authButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 0.118, green: 0.137, blue: 0.173, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAuthButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAuthButton()
    }
    
    private func setupAuthButton() {
        addSubview(authButton)
        
        authButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            authButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            authButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            authButton.heightAnchor.constraint(equalToConstant: 56),
            authButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -298)
        ])
    }
}
