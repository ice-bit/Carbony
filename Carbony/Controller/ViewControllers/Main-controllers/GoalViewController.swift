//
//  UpdateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 18/08/23.
//

import UIKit

class GoalViewController: UIViewController {
    
    // MARK: - Outlets and properties
    @IBOutlet weak var goalTableView: UITableView!
    
    var footprints: [CarbonFootprint] = []
    
    var goals: [Goal] = []
    var visibleGoals: [Goal] = []
    
    var isSectionZeroVisible: Bool = true
    var isSectionOneVisibile: Bool = true
    
//    var isExpanded: Bool = false
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        goalTableView.dataSource = self
        goalTableView.delegate = self
        goalTableView.separatorStyle = .none
        
        DBController.shared.createGoalsTable()
//        DBController.shared.displayGoals()
        goals = DBController.shared.fetchGoals()
        visibleGoals = goals.reversed()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addGoal(notification:)), name: Notification.Name("AddGoalNotification"), object: nil)
    }
    
   override func viewWillAppear(_ animated: Bool) {
       print(#function)
        super.viewWillAppear(animated)
        goals = DBController.shared.fetchGoals()
        visibleGoals = goals.reversed()
        goalTableView.reloadData()
    }
    
    // Deinitializer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - OBJC methods
    @objc private func addGoal(notification: Notification) {
        if let newGoal = notification.object as? Goal {
            DBController.shared.displayGoals()
            goals.append(newGoal)
            visibleGoals = goals.reversed()
            
            if let newIndex = visibleGoals.firstIndex(where: { $0 == newGoal }) {
                let sectionToReload = 0
                let indexPathToReload = IndexPath(row: newIndex, section: sectionToReload)
                
                goalTableView.beginUpdates()
                goalTableView.insertRows(at: [indexPathToReload], with: .automatic)
                goalTableView.endUpdates()
                
                DispatchQueue.main.async {
                    // Scroll to the top
                    self.goalTableView.scrollToRow(at: indexPathToReload, at: .top, animated: true)
                    
                    if let cell = self.goalTableView.cellForRow(at: indexPathToReload) {
                        cell.backgroundColor = UIColor.systemGray5
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    if let cell = self.goalTableView.cellForRow(at: indexPathToReload) {
                        cell.backgroundColor = UIColor.white
                    }
                }
            }
        }
    }
}
// MARK: - UITableViewDataSource extension
extension GoalViewController: UITableViewDataSource {
    // configure numebr of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // configure title for section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Goals" : "Footprints"
    }
    
    // configure number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? visibleGoals.count : footprints.count
    }
    
    // configure cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = goalTableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as! GoalTableViewCell
        
        if indexPath.section == 0 && indexPath.row < goals.count  {
            cell.updateCell(withGoal: visibleGoals[indexPath.row])
        } else if indexPath.section == 1 && indexPath.row < footprints.count{
            // TODO: populate the cell
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate extension
extension GoalViewController: UITableViewDelegate {
    // configure height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108.0
    }
    
    // pass view to the section heeader
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let customHeaderView = GoalSectionHeaderView()
        customHeaderView.tag = section
        customHeaderView.delegate = self
        if section == 0 {
            customHeaderView.headerLabel.text = "Goals"
        } else {
            customHeaderView.headerLabel.text = "Footprints"
        }
        customHeaderView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
        return customHeaderView
    }
    
    // configure height of the section hearder view
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 49.0
    }
    
    // action on selecting the cell
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

// MARK: - GoalSectionHeaderViewDelegate
extension GoalViewController: GoalSectionHeaderViewDelegate {
    /*func updateToggleCellButtonImage(forButton: UIButton) {
        isExpanded.toggle()
        let imageName = isExpanded ? "chevron.up" : "chevron.down"
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
        let image = UIImage(systemName: imageName, withConfiguration: symbolConfiguration)
        forButton.setImage(image, for: .normal)
    }*/

    // show and hide the cells
    func toggleButtonTapped(inSection section: Int) {
        if section == 0 {
            isSectionZeroVisible.toggle()
            if isSectionZeroVisible {
                visibleGoals = goals.reversed()
            } else {
                visibleGoals.removeAll()
            }
        } else if section == 1 {
            isSectionOneVisibile.toggle()
        }
        
        goalTableView.reloadData()
    }
    
    // action for add button in add goals section header
    func addButtonTapped(inSection section: Int) {
        if section == 0 {
            //print("Present addGoal controller.")
            let addGoalViewController = AddGoalViewController()
            let rootViewController = UINavigationController(rootViewController: addGoalViewController)
            // present
            self.present(rootViewController, animated: true)
        } else {
            //print("Present addFootprint controller.")
            let calculateVC = CalculateViewController()
            let rootVC = UINavigationController(rootViewController: calculateVC)
            self.present(rootVC, animated: true)
        }
    }
}
