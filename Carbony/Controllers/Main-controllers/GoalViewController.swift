//
//  UpdateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 18/08/23.
//
///Users/doss-zstch1212/Developer/Xcode/Garage/Carbony/Carbony/Login-Module/Controllers/Main-controllers/EcoViewController.swift

import UIKit

class GoalViewController: UIViewController {

    @IBOutlet weak var goalTableView: UITableView!
    
    var footprints: [Footprint] = []
    
    var goals: [Goal] = []
    var isSectionZeroVisible: Bool = true
    var isSectionOneVisibile: Bool = true
    var visibleGoals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.dataSource = self
        goalTableView.delegate = self
        goalTableView.separatorStyle = .none
        
        DBController.shared.createGoalsTable()
        DBController.shared.printAllDetailsFromDatabase()
        goals = DBController.shared.readGoalTable()
        visibleGoals = goals
        
        NotificationCenter.default.addObserver(self, selector: #selector(addGoal(notification:)), name: Notification.Name("AddGoalNotification"), object: nil)
    }
    
    @objc private func addGoal(notification: Notification) {
        if let newGoal = notification.object as? Goal {
            DBController.shared.printAllDetailsFromDatabase()
            goals.append(newGoal)
            visibleGoals = goals
            goalTableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension GoalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Goals" : "Footprints"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? visibleGoals.count : footprints.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = goalTableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as! GoalTableViewCell
        
        if indexPath.section == 0 && indexPath.row < goals.count  {
            cell.updateCell(withGoal: visibleGoals[indexPath.row].)
        } else if indexPath.section == 1 && indexPath.row < footprints.count{
            // TODO: populate the cell
        }
        
        return cell
    }
}

extension GoalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderView = GoalSectionHeaderView()
        customHeaderView.tag = section
        customHeaderView.delegate = self
        if section == 0 {
            customHeaderView.headerLabel.text = "Goals"
        } else {
            customHeaderView.headerLabel.text = "Footprints"
        }
        customHeaderView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.85)
        return customHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49.0
    }
    
    // Presenting a vc for the selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row < goals.count {
            let selectedGoal = visibleGoals[indexPath.row]
            
            let goalDetailedViewController  = GoalDetailedViewController()
            
            goalDetailedViewController.selectedGoal = selectedGoal
            
            self.navigationController?.pushViewController(goalDetailedViewController, animated: true)
            
        } else if indexPath.row == 1 && indexPath.row < footprints.count {
            // TODO: Handle the footprint selction
        }
    }
}

extension GoalViewController: GoalSectionHeaderViewDelegate {
    func toggleButtonTapped(inSection section: Int) {
        if section == 0 {
            isSectionZeroVisible.toggle()
            if isSectionZeroVisible {
                visibleGoals = goals
            } else {
                visibleGoals.removeAll()
            }
        } else if section == 1 {
            isSectionOneVisibile.toggle()
        }
//        goalTableView.reloadSections(IndexSet(integer: section), with: .fade)
        goalTableView.reloadData()
    }
    
    func addButtonTapped(inSection section: Int) {
        if section == 0 {
            print("Present addGoal controller.")
            let addGoalViewController = AddGoalViewController()
            let rootViewController = UINavigationController(rootViewController: addGoalViewController)
            self.present(rootViewController, animated: true)
        } else {
            print("Present addFootprint controller.")
        }
    }
}
