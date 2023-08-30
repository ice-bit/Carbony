//
//  UpdateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 18/08/23.
//
///Users/doss-zstch1212/Developer/Xcode/Garage/Carbony/Carbony/Login-Module/Controllers/Main-controllers/EcoViewController.swift

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var goalTableView: UITableView!
    
    let firstSectionData = ["Row 1", "Row 2", "Row 3"]
    let secondSectionData = ["Row A", "Row B","Row C","Row D","Row E","Row F"]
    
    var goals: [Goal] = []
    var isSectionZeroVisible: Bool = true
    var isSectionOneVisibile: Bool = true
    var visibleGoals: [Goal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalTableView.dataSource = self
        goalTableView.delegate = self
        goalTableView.separatorStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(addGoal(notification:)), name: Notification.Name("AddGoalNotification"), object: nil)
    }
    
    @objc private func addGoal(notification: Notification) {
        if let newGoal = notification.object as? Goal {
            goals.append(newGoal)
            visibleGoals = goals
            goalTableView.reloadData()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension UpdateViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Goals" : "Footprints"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? visibleGoals.count : secondSectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = goalTableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as! GoalTableViewCell
        
        if indexPath.section == 0 && indexPath.row < visibleGoals.count  {
            cell.updateCell(goal: visibleGoals[indexPath.row])
        } else if indexPath.section == 1 && indexPath.row < secondSectionData.count{
            //
        }
        
        return cell
    }
}

extension UpdateViewController: UITableViewDelegate {
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
}

extension UpdateViewController: GoalSectionHeaderViewDelegate {
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
