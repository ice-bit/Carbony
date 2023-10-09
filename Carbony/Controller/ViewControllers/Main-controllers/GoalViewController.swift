//
//  UpdateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 18/08/23.
//

import UIKit

class GoalViewController: UIViewController {
    
    // MARK: - Outlets and properties
    @IBOutlet weak var GoalAndFootprintTableView: UITableView!
    
    var footprintsData: [CarbonFootprint] = [] /// - SeeAlso `fetchFootprintsData()`
    
    var isSectionCollapsed: [Bool] = [false, false]
    
    var goals: [Goal] = [] /// - SeeAlso `fetchGoalsData()`
 
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        GoalAndFootprintTableView.dataSource = self
        GoalAndFootprintTableView.delegate = self
        GoalAndFootprintTableView.separatorStyle = .none
        
        DBController.shared.createGoalsTable()
        DBController.shared.createFootprintTable()
        fetchGoalsData()
        fetchFootprintsData()
        
        registerCells()
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        footprintsData.removeAll()
        goals.removeAll()
        fetchGoalsData()
        fetchFootprintsData()
        isSectionCollapsed = [false, false]
        GoalAndFootprintTableView.reloadData()
    }*/
    
    
    // MARK: - OBJC methods

    
    // MARK: - private methods
    private func registerCells() {
        GoalAndFootprintTableView.register(FootprintTableViewCell.self, forCellReuseIdentifier: FootprintTableViewCell.reuseIdentifier)
    }
    
    private func fetchFootprintsData() {
        DBController.shared.fetchFootprints { fetchedFootprints, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let footprints = fetchedFootprints {
                for footprint in footprints {
                    self.footprintsData.append(footprint)
                    self.footprintsData.reverse()
                }
            }
        }
    }
    
    private func fetchGoalsData() {
        DBController.shared.fetchGoals { incomingGoals, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let fetchedGoals = incomingGoals {
                for goal in fetchedGoals {
                    self.goals.append(goal)
                    self.goals.reverse()
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
        if section == 0 {
            return isSectionCollapsed[section] ? 0 : goals.count
        } else {
            return isSectionCollapsed[section] ? 0 : footprintsData.count
        }
    }
    
    // configure cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let goalCell = GoalAndFootprintTableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as? GoalTableViewCell {
                goalCell.updateCell(withGoal: goals[indexPath.row])
                
                return goalCell
            }
        } else if indexPath.section == 1 {
            if let footprintCell = GoalAndFootprintTableView.dequeueReusableCell(withIdentifier: FootprintTableViewCell.reuseIdentifier, for: indexPath) as? FootprintTableViewCell {
                footprintCell.updateCell(with: footprintsData[indexPath.row])
                
                return footprintCell
            }
        }
        
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate extension
extension GoalViewController: UITableViewDelegate {
    // configure height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 108.0
        } else {
            return 88.0
        }
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
            let selectedGoal = goals[indexPath.row]
            
            let goalDetailedViewController  = GoalDetailedViewController()
            
            goalDetailedViewController.selectedGoal = selectedGoal
            
            self.navigationController?.pushViewController(goalDetailedViewController, animated: true)
            
        } else if indexPath.row == 1 && indexPath.row < footprintsData.count {
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
            isSectionCollapsed[section].toggle()
            GoalAndFootprintTableView.reloadSections(IndexSet(integer: 0), with: .none)
        } else if section == 1 {
            isSectionCollapsed[section].toggle()
            GoalAndFootprintTableView.reloadSections(IndexSet(integer: 1), with: .none)
        }
        
        
    }
    
    // action for add button in add goals section header
    func addButtonTapped(inSection section: Int) {
        if section == 0 {
            let addGoalViewController = AddGoalViewController()
            addGoalViewController.isSectionCollapsed = self.isSectionCollapsed
            addGoalViewController.reloadDelegate = self
            let rootViewController = UINavigationController(rootViewController: addGoalViewController)
            self.present(rootViewController, animated: true)
        } else {
            let calculateVC = CalculateViewController()
            calculateVC.reloadDelegate = self
            let rootVC = UINavigationController(rootViewController: calculateVC)
            self.present(rootVC, animated: true)
        }
    }
}

// MARK: - Delagate for reloading the goal table on dismissal of the table view
extension GoalViewController: DataReloadDelegate {
    func reloadGoalData() {
        goals.removeAll()
        fetchGoalsData()
        isSectionCollapsed[0] = false
        self.GoalAndFootprintTableView.reloadData()
        
        GoalAndFootprintTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        if let cell = GoalAndFootprintTableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
            cell.contentView.backgroundColor = UIColor.systemGray6
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                cell.contentView.backgroundColor = UIColor.systemBackground
            }
        }
    }
    
    func reloadFootprintData() {
        footprintsData.removeAll()
        fetchFootprintsData()
        isSectionCollapsed[1] = false
        self.GoalAndFootprintTableView.reloadData()
        
        GoalAndFootprintTableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
        if let cell = GoalAndFootprintTableView.cellForRow(at: IndexPath(row: 0, section: 1)) {
            cell.contentView.backgroundColor = UIColor.systemGray6
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                cell.contentView.backgroundColor = UIColor.systemBackground
            }
        }
    }
}
