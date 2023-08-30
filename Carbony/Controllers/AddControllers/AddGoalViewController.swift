//
//  AddGoalViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 21/08/23.
//

import UIKit

class AddGoalViewController: UIViewController {

    @IBOutlet weak var addGoalButton: UIButton!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var targetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddGoalButton()
        self.title = "Add Goal"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func addGoalButtonTapped(_ sender: Any) {
        guard let description = descriptionTextField.text,
              let targetText = targetTextField.text,
              let target = Int(targetText),
              target > 1000,
              !description.isEmpty else {
                  return
              }
        
        let newGoal = Goal(target: target, targetLeft: target, progress: 0, description: description)
        
        let createTableQuery = """
        CREATE TABLE IF NOT EXISTS goals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            target INTEGER,
            targetLeft INTEGER,
            progress INTEGER,
            description TEXT
        );
        """

        
        let insertQuery = "INSERT INTO goals (target, targetLeft, progress, description) VALUES (\(newGoal.target), \(newGoal.targetLeft), \(newGoal.progress), '\(newGoal.description)');"
        

        if DBManager.shared.executeNonQuery(query: createTableQuery) {
            print("Goals table created successfully or already exists")
        } else {
            print("Error creating goals table")
        }
        
//        let insertQuery = "INSERT INTO goals (target, targetLeft, progress, description) VALUES (\(newGoal.target), \(newGoal.targetLeft), \(newGoal.progress), '\(newGoal.description)')"
        print("Insert query: \(insertQuery)")
        if DBManager.shared.executeNonQuery(query: insertQuery) {
            print("Goal inserted into database successfully")
        } else {
            print("Error inserting goal into database")
        }
        
        NotificationCenter.default.post(name: Notification.Name("AddGoalNotification"), object: newGoal)
        
        dismiss(animated: true)
    }
    private func setupAddGoalButton() {
        addGoalButton.layer.cornerRadius = 8
    }
    
    private func setupCancelButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBarButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc private func cancelBarButtonTapped() {
        self.dismiss(animated: true)
    }
}
