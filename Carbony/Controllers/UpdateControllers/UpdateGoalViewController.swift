//
//  UpdateGoalViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 07/09/23.
//

import UIKit

protocol UpdateGoalDelegate {
    func setUpdatedGoal(with goal: Goal)
}

class UpdateGoalViewController: UIViewController {
    // MARK: - Properties and UIElements
    var selectedGoal: Goal?
    var delegate: UpdateGoalDelegate?
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Progress value"
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let updateButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .label
        button.layer.cornerRadius = 8
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /*// constants
     let defaultHeight: CGFloat = 300
     let dismissibleHeight: CGFloat = 200
     let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
     // keep the current view hieight
     var currentContainerHeight: CGFloat = 300*/
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Update Goal"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupCancelButton()
        setupUpdateGoalSceneUI()
    }
    
    // MARK: - OBJC methods
    @objc private func cancelButtonAction() {
        self.dismiss(animated: true)
    }
    
    @objc private func updateButtonAction() {
        // TODO: - Update goaland update goal in table
        print("Update button tapped")
        if let inputText = inputTextField.text,
           let inputValue = Int(inputText) {
            if let goal = selectedGoal {
                let updatedGoal = updateGoal(for: goal, with: inputValue)
//                print("Updated Goal: Goal(uuid: \(updatedGoal.uuid), target: \(updatedGoal.target), targetLeft: \(updatedGoal.targetLeft), progress: \(updatedGoal.progress), description: \(updatedGoal.description))")
                
                DBController.shared.updateGoal(uuid: updatedGoal.uuid.uuidString, newProgress: updatedGoal.progress, newTargetLeft: updatedGoal.targetLeft)
                // calling the delegate func
                delegate?.setUpdatedGoal(with: updatedGoal)
                let fetchUpdatedGoal = DBController.shared.readGoal(withUUID: updatedGoal.uuid.uuidString)
                print("Updated goal: UUID: \(fetchUpdatedGoal?.uuid), newProgress: \(fetchUpdatedGoal?.progress)")
             }
        }
        
        self.dismiss(animated: true)
    }
    
    // MARK: - Private methods
    private func setupCancelButton() {
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonAction))
        self.navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    private func setupUpdateGoalSceneUI() {
        view.addSubview(inputTextField)
        view.addSubview(updateButton)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            updateButton.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 44),
            
            inputTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            updateButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            inputTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            updateButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.85),
            
            updateButton.heightAnchor.constraint(equalToConstant: 56),
            inputTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        updateButton.addTarget(self, action: #selector(updateButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Public methods
    func updateGoal(for goal: Goal, with value: Int) -> Goal {
        let currentProgress = goal.progress
        let totalTarget = goal.target
        let targetLeft = goal.targetLeft
        let precentageProgress = Double(currentProgress) / Double(totalTarget)
        let newPercentageProgress = precentageProgress + (Double(value) / Double(totalTarget))
        
        let clampedPercentage = min(max(newPercentageProgress, 0), 1.0)
        let remainingTarget = max(targetLeft - value, 0)
        
        let updatedGoal = Goal(uuid: goal.uuid, target: goal.target, targetLeft: remainingTarget, progress: clampedPercentage, description: goal.description)
        
        return updatedGoal
    }
}
