//
//  GoalDetailedViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/09/23.
//

import UIKit

class GoalDetailedViewController: UIViewController {
    var selectedGoal: Goal?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.systemBackground
        setupButtons()
    }
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        button.backgroundColor = .systemFill
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let updateButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("Update", for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupButtons() {
        view.addSubview(cancelButton)
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            cancelButton.widthAnchor.constraint(equalToConstant: 175),
            cancelButton.heightAnchor.constraint(equalToConstant: 49),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56),
            
            updateButton.widthAnchor.constraint(equalToConstant: 175),
            updateButton.heightAnchor.constraint(equalToConstant: 49),
            updateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56)
        ])
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }

}
