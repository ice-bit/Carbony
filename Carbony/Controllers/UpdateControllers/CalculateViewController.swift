//
//  CalculateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 05/09/23.
//

import UIKit

class CalculateViewController: UIViewController {
    // MARK: Properties
    var regularConstraints: [NSLayoutConstraint] = []
    var compactConstraints: [NSLayoutConstraint] = []
    
    let typeSegementController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["Driving", "Electricity"])
        /*segmentController.setTitle("Driving", forSegmentAt: 0)
        segmentController.setTitle("Electricity", forSegmentAt: 1)*/
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        return segmentController
    }()
    
    let resultContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = .cyan
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "3412"
        label.font = UIFont.systemFont(ofSize: 64, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "tons of Co2"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textFieldStackView: UIStackView = {
       let stackView = UIStackView()
//        stackView.backgroundColor = .cyan
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let typeSelectionTextField: UITextField = {
        let textField = CFTextField()
        textField.placeholder = "Choose a type"
        return textField
    }()
    
    let distanceTravelledTextField: UITextField = {
        let textField = CFTextField()
        textField.placeholder = "Km travelled"
        return textField
    }()
    
    let vehicleEfficienyTextField: UITextField = {
        let textField = CFTextField()
        textField.placeholder = "Vehicle efficiency"
        return textField
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        //stackView.backgroundColor = .black
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let calculateButton: UIButton = {
        let button = CFCustomButton()
        button.setTitle("Calculate", for: .normal)
        return button
    }()

    let addFootprintButton: UIButton = {
        let button = CFCustomButton()
        button.customBackgroundColor = UIColor.label
        button.setTitle("Add Footprint", for: .normal)
        button.customTextColor = UIColor.systemBackground
        return button
    }()
    
    // MARK: - View lifecylce methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calculate Footprint"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupCancelButton()
        setupAndActivateContraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NSLayoutConstraint.deactivate(compactConstraints)
        NSLayoutConstraint.deactivate(regularConstraints)
        
        if self.traitCollection.verticalSizeClass == .compact {
            print("hC")
            NSLayoutConstraint.activate(compactConstraints)
        } else if self.traitCollection.verticalSizeClass == .regular && self.traitCollection.horizontalSizeClass == .regular {
            print("wR & hR")
        } else {
            print("hW, wR & hR, anything other than this")
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    // MARK: - OBJC methods
    @objc private func cancelBarButtonAction() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Private methods
    private func setupCancelButton() {
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBarButtonAction))
        self.navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    private func setupAndActivateContraints() {
        view.addSubview(resultContainerView)
        resultContainerView.addSubview(resultLabel)
        resultContainerView.addSubview(resultUnitLabel)
        view.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(typeSelectionTextField)
        textFieldStackView.addArrangedSubview(distanceTravelledTextField)
        textFieldStackView.addArrangedSubview(vehicleEfficienyTextField)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(calculateButton)
        buttonStackView.addArrangedSubview(addFootprintButton)
        view.addSubview(typeSegementController)
        
       /* if typeSegementController.selectedSegmentIndex == 0 {
            vehicleEfficienyTextField.text = "Eureka"
        }*/
        
        regularConstraints = [
            // segment controller constraints
            typeSegementController.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            typeSegementController.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            // TopResultContainer
            resultContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            resultContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            resultContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultContainerView.heightAnchor.constraint(equalToConstant: 98),
            
            // resultLabel constraints
            resultLabel.leadingAnchor.constraint(equalTo: resultContainerView.leadingAnchor, constant: 8),
            resultLabel.topAnchor.constraint(equalTo: resultContainerView.topAnchor, constant: 8),
            
            // resultLabel constraints
            resultUnitLabel.leadingAnchor.constraint(equalTo: resultLabel.trailingAnchor, constant: 2),
            resultUnitLabel.bottomAnchor.constraint(equalTo: resultContainerView.bottomAnchor, constant: -26),
            
            // textFieldStackView constraints
            textFieldStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31),
            textFieldStackView.topAnchor.constraint(equalTo: resultContainerView.bottomAnchor, constant: 0),
            textFieldStackView.heightAnchor.constraint(equalToConstant: 204),
            
            // button stackView constraints
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 31),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -31),
            buttonStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 44),
            buttonStackView.heightAnchor.constraint(equalToConstant: 49)
        ]
        
        if self.traitCollection.verticalSizeClass == .compact {
            print("hC")
            NSLayoutConstraint.activate(compactConstraints)
        } else if self.traitCollection.verticalSizeClass == .regular && self.traitCollection.horizontalSizeClass == .regular {
            print("wR & hR")
        } else {
            print("hW, wR & hR, anything other than this")
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
}
