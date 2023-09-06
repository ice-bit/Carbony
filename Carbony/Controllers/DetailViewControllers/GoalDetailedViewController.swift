//
//  GoalDetailedViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/09/23.
//

import UIKit

class GoalDetailedViewController: UIViewController {
    // MARK: - Properties
    var selectedGoal: Goal?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        setupUI()
    }
    
    // MARK: - UIComponents initializatiion
    
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
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 64, weight: .heavy)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let percentageIconLabel: UILabel = {
       let label = UILabel()
        label.text = "%"
        label.font = UIFont.systemFont(ofSize: 64, weight: .heavy)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ofLabel: UILabel = {
        let label = UILabel()
        label.text = "of"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let targetLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabelText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let updateValueTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Value"
        textField.borderStyle = .roundedRect
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - Setup UI methods
    
    private func setupUI() {
        setupLabels()
        setupDescriptionContainerView()
        setupDescriptionLabel()
        setupDescriptionLabelText()
        setupUpdateValueTextField()
        setupButtons()
    }
    
    private func setupButtons() {
        view.addSubview(cancelButton)
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            // cancelButton constraints
            cancelButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5,constant: -20),
            cancelButton.heightAnchor.constraint(equalToConstant: 49),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56),
            cancelButton.topAnchor.constraint(equalTo: updateValueTextField.bottomAnchor, constant: 56),
            // updateButton constraints
            updateButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5,constant: -20),
            updateButton.heightAnchor.constraint(equalToConstant: 49),
            updateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -56)
            updateButton.topAnchor.constraint(equalTo: updateValueTextField.bottomAnchor, constant: 56)
        ])
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }

//    private func setupUpdateButton
    
    private func setupLabels() {
        view.addSubview(progressLabel)
        view.addSubview(percentageIconLabel)
        view.addSubview(ofLabel)
        view.addSubview(targetLeftLabel)
        
        if let progress = selectedGoal?.progress {
            progressLabel.text = String(progress)
        }
        
        if let targetLeft = selectedGoal?.targetLeft {
            targetLeftLabel.text = String(targetLeft)
        }
        
        NSLayoutConstraint.activate([
            // progressLabel constraints
            progressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            // percentageLabel constraints
            percentageIconLabel.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 2),
            percentageIconLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23),
            // ofLabel constraints
            ofLabel.leadingAnchor.constraint(equalTo: percentageIconLabel.trailingAnchor, constant: 2),
            ofLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            // targetLeftLabel constraints
            targetLeftLabel.leadingAnchor.constraint(equalTo: ofLabel.trailingAnchor, constant: 2),
            targetLeftLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65)
        ])
    }
    
    // DescriptionContainerView Constraints
    private func setupDescriptionContainerView() {
        view.addSubview(descriptionContainerView)
        
        NSLayoutConstraint.activate([
            descriptionContainerView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            descriptionContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
           /* descriptionContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            descriptionContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),*/
            descriptionContainerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            descriptionContainerView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionContainerView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            // descriptionLabel constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor, constant: 8)
        ])
    }
    
    private func setupDescriptionLabelText() {
        descriptionContainerView.addSubview(descriptionLabelText)
        
        if let descriptionText = selectedGoal?.description {
            descriptionLabelText.text = String(descriptionText)
        }
        
        NSLayoutConstraint.activate([
            // descriptionlabelText constraints
            descriptionLabelText.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 24),
            descriptionLabelText.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 8),
            descriptionLabelText.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupUpdateValueTextField() {
        view.addSubview(updateValueTextField)
        
        NSLayoutConstraint.activate([
            updateValueTextField.topAnchor.constraint(equalTo: descriptionContainerView.bottomAnchor, constant: 20),
            updateValueTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            updateValueTextField.heightAnchor.constraint(equalToConstant: 44),
            updateValueTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    // MARK: - OBJC methods
    
    @objc private func updateButtonTapped() {
        print("Update button tapped")
    }
    
    @objc private func cancelButtonTapped() {
        self.dismiss(animated: true)
    }

}
