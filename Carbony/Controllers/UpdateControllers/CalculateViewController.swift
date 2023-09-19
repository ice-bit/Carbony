//
//  CalculateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 05/09/23.
//

import UIKit

class CalculateViewController: UIViewController {
    // MARK: Properties
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
        stackView.backgroundColor = .cyan
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - View lifecylce methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calculate Footprint"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //setupCancelButton()
        setupAndActivateContraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if size.width > size.height {
            print("Landscape")
            setupAndActivateContraints()
        } else {
            print("Portrait")
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
        
        if self.traitCollection.verticalSizeClass == .compact {
            print("hW")
        } else if self.traitCollection.verticalSizeClass == .regular && self.traitCollection.horizontalSizeClass == .regular {
            print("wR & hR")
        } else {
            print("hW, wR & hR, anything other than this")
            NSLayoutConstraint.activate([
                // TopResultContainer
                resultContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
                resultContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
                resultContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
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
                textFieldStackView.heightAnchor.constraint(equalToConstant: 204)
            ])
        }
    }
}
