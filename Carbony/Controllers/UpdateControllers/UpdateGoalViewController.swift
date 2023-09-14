//
//  UpdateGoalViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 07/09/23.
//

import UIKit
protocol UpdateGoalDelegate {
    func didUpdateGoal(updatedGoal goal: Goal)
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
        // TODO: Update goal and update goal in table
        /// dumbass check the flow you should post to the db here and fetch the data in the detailView Controller!
        print("Update button tapped")
        guard let goalProgress = selectedGoal?.progress, goalProgress < 100 else {
            progressCompletionAlert()
            return
        }
        
        if let inputText = inputTextField.text,
           let inputValue = Int(inputText) {
            if inputValue >= 0 {
                if let goal = selectedGoal {
                    let updatedGoal = updateGoal(for: goal, with: inputValue)
                    DBController.shared.updateGoal(uuid: updatedGoal.uuid.uuidString, newProgress: updatedGoal.progress, newTargetLeft: updatedGoal.targetLeft)
                    delegate?.didUpdateGoal(updatedGoal: updatedGoal)
                    self.dismiss(animated: true)
                } else {
                    print("Couldn't unwrap goal from selectedGoal")
                }
                self.dismiss(animated: true)
            } else {
                displayErrorMessage("Invalid input. Please enter a valid number.")
            }
        } else {
            displayErrorMessage("Invalid input. Please enter a valid whole number.")
        }
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
    func updateGoal(for goal: Goal, with reducedEmissionValue: Int) -> Goal {
        let totalTarget = Double(goal.target)
        let targetLeft = Double(goal.targetLeft)
        let currentProgress: Double = ((totalTarget - targetLeft ) / totalTarget) * 100.0
        let newProgress: Double = Double(reducedEmissionValue) / Double(totalTarget) * 100.0
        let clampedProgress = min(max(newProgress + currentProgress, 0), 100)
    
        let newTargetLeft = max(Int(targetLeft) - reducedEmissionValue, 0)
        
        let updatedGoal = Goal(uuid: goal.uuid, target: goal.target, targetLeft: newTargetLeft, progress: Int(clampedProgress), description: goal.description)
        
        return updatedGoal
    }
    
    // MARK: - private methods
    private func displayErrorMessage(_ message: String) {
        // You can implement a UIAlert or other UI to display the error message to the user
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    private func progressCompletionAlert() {
        let alertController = UIAlertController(title: "Progress already 100%", message: "You cannot update the progress because it's already at 100%.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { [weak self] _  in
            self?.dismiss(animated: true)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
