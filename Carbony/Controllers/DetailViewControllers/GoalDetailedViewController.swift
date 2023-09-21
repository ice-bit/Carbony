//
//  GoalDetailedViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/09/23.
///A58A8730-415A-4C5E-A72A-C0F50CF05533
///A58A8730-415A-4C5E-A72A-C0F50CF05533

import UIKit

class GoalDetailedViewController: UIViewController {
    // MARK: - Properties
    var selectedGoal: Goal?
    
    // MARK: - UIComponents initializatiion
    let calculateButton: UIButton = {
        let button = CFCustomButton()
        button.setTitle("Calculate", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let updateButton: UIButton = {
        let button = CFCustomButton()
        button.setTitle("Update", for: .normal)
        button.customBackgroundColor = .label
        button.customTextColor = .systemBackground
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
    
    let targetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionContainerView: UIView = {
        let containerView = UIView()
        //containerView.backgroundColor = UIColor.systemGray6
        containerView.backgroundColor = UIColor(named: "CustomMainBackgroundColor") ?? UIColor.systemGray6
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
    
    let targetLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        self.title = "Goal"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        
    }
    // MARK: - OBJC methods
    @objc private func updateButtonTapped() {
        print("Update button tapped")
        
        if let selectedGoal = selectedGoal, selectedGoal.progress == 100 {
            let alertController = UIAlertController(title: "Progress already 100%", message: "You cannot update the progress because it's already at 100%.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
        } else {
            if let goalUUID = selectedGoal?.uuid, let fetchedGoal = fetchGoal(with: goalUUID) {
                let updateViewController = UpdateGoalViewController()
                
                updateViewController.delegate = self
                updateViewController.selectedGoal = fetchedGoal
                
                let nav = UINavigationController(rootViewController: updateViewController)
                nav.modalPresentationStyle = .pageSheet
                if let sheet = nav.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                    sheet.selectedDetentIdentifier = .large
                    sheet.prefersGrabberVisible = true
                }
                
                self.navigationController?.present(nav, animated: true)
            } else {
                print("Failed to fetch the goal with UUID: \(String(describing: selectedGoal?.uuid))")
            }
        }
    }
    
    @objc private func calculateButtonAction() {
        print("Calculate button tapped")
        let calculateViewController = CalculateViewController()
        let rootVC = UINavigationController(rootViewController: calculateViewController)
        self.present(rootVC, animated: true)
    }
    
    
    
    // MARK: - Setup UI methods
    
    private func setupUI() {
        setupLabels()
        setupDescriptionContainerView()
        setupButtons()
    }
    
    private func setupButtons() {
        view.addSubview(calculateButton)
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            calculateButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5,constant: -25),
            updateButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5,constant: -25),
            
            /*cancelButton.topAnchor.constraint(equalTo: updateValueTextField.bottomAnchor, constant: 56),
            updateButton.topAnchor.constraint(equalTo: updateValueTextField.bottomAnchor, constant: 56),*/
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            updateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            updateButton.heightAnchor.constraint(equalToConstant: 49),
            calculateButton.heightAnchor.constraint(equalToConstant: 49),
            
            calculateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            updateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        calculateButton.addTarget(self, action: #selector(calculateButtonAction), for: .touchUpInside)
    }

//    private func setupUpdateButton
    
    private func setupLabels() {
        view.addSubview(progressLabel)
        view.addSubview(percentageIconLabel)
        view.addSubview(ofLabel)
        view.addSubview(targetLabel)
        
    if let progress = selectedGoal?.progress {
            progressLabel.text = String(progress)
        }
        
        if let target = selectedGoal?.target {
            targetLabel.text = String(target)
        }
        
        NSLayoutConstraint.activate([
            // progressLabel constraints
            progressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            progressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            // percentageLabel constraints
            percentageIconLabel.leadingAnchor.constraint(equalTo: progressLabel.trailingAnchor, constant: 2),
            percentageIconLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            // ofLabel constraints
            ofLabel.leadingAnchor.constraint(equalTo: percentageIconLabel.trailingAnchor, constant: 2),
            ofLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            // targetLeftLabel constraints
            targetLabel.leadingAnchor.constraint(equalTo: ofLabel.trailingAnchor, constant: 2),
            targetLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
        ])
    }
    
    // DescriptionContainerView Constraints
    private func setupDescriptionContainerView() {
        view.addSubview(descriptionContainerView)
        descriptionContainerView.addSubview(descriptionLabel)
        descriptionContainerView.addSubview(descriptionLabelText)
        descriptionContainerView.addSubview(targetLeftLabel)
        
        if let descriptionText = selectedGoal?.description {
            descriptionLabelText.text = String(descriptionText)
        }
        
        if let targetLeft = selectedGoal?.targetLeft {
            targetLeftLabel.text = String(targetLeft)
        }
        
        NSLayoutConstraint.activate([
            descriptionContainerView.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 16),
            descriptionContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            descriptionContainerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor, constant: 8),
            
            descriptionLabelText.topAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: 24),
            descriptionLabelText.leadingAnchor.constraint(equalTo: descriptionContainerView.leadingAnchor, constant: 8),
            descriptionLabelText.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -8),
            descriptionContainerView.bottomAnchor.constraint(equalTo: descriptionLabelText.bottomAnchor, constant: 8),
            
            targetLeftLabel.trailingAnchor.constraint(equalTo: descriptionContainerView.trailingAnchor, constant: -8),
            targetLeftLabel.topAnchor.constraint(equalTo: descriptionContainerView.topAnchor, constant: 8)
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
    
    private func fetchGoal(with uuid: UUID) -> Goal? {
        let goals = DBController.shared.fetchGoals()
        for goal in goals {
            if goal.uuid == uuid {
                let fetchedGoal = goal
                return fetchedGoal
            }
        }
        print("No goals found with UUID: \(uuid)")
        return nil
    }
}

// MARK: - extensions
extension GoalDetailedViewController: UpdateGoalDelegate {
    func didUpdateGoal(updatedGoal goal: Goal) {
        progressLabel.text = String(goal.progress)
        targetLeftLabel.text = String(goal.targetLeft)
    }
}
