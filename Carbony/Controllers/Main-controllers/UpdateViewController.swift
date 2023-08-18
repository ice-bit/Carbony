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
    let secondSectionData = ["Row A", "Row B"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension UpdateViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Goals"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? firstSectionData.count : secondSectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = goalTableView.dequeueReusableCell(withIdentifier: "GoalTableViewCell", for: indexPath) as? GoalTableViewCell
        
        if indexPath.section == 1 {
            cell!.myTextLabel.text = firstSectionData[indexPath.row]
        } else {
            cell!.myTextLabel.text = secondSectionData[indexPath.row]
        }
        
        return cell!
    }
}
