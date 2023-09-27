//
//  SummaryViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 16/08/23.
//

import UIKit

class SummaryViewController: UIViewController {
    // MARK: - properties and outlets
    @IBOutlet weak var summaryTableView: UITableView!
    
    @IBOutlet weak var userSettingsBarButton: UIBarButtonItem!
    
    // MARK: - lifeCyle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // register the cells
        summaryTableView.register(FootprintDisplayCell.self, forCellReuseIdentifier: FootprintDisplayCell.reuseIdentifier)
        summaryTableView.register(CustomProgressTableViewCell.self, forCellReuseIdentifier: CustomProgressTableViewCell.reuseIdentifier)
        summaryTableView.register(GraphDemoTableViewCell.self, forCellReuseIdentifier: GraphDemoTableViewCell.reuseIdentifier)
        
        summaryTableView.separatorStyle = .none
        summaryTableView.allowsSelection = false
        
        summaryTableView.delegate = self
        summaryTableView.dataSource = self
    }
    
    // MARK: - OBJC methods
    
    // MARK: - private methods
    
}

// MARK: - TableViewDelegate
extension SummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            // first cell height
            return 80
        } else if indexPath.section == 0 && indexPath.row == 1 {
            return 262
        } else if indexPath.section == 1 {
            return 84
        }
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let summaryHeaderView = CFTableViewSectionHeaderView()
            summaryHeaderView.customTitle = "Summary"
            summaryHeaderView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
            return summaryHeaderView
        } else if section == 1 {
            let progressHeaderView = CFTableViewSectionHeaderView()
            progressHeaderView.customTitle = "Progress"
            progressHeaderView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
            return progressHeaderView
        }
        
        return nil
    }
}

// MARK: TableView Datasource
extension SummaryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            if indexPath.row == 0 {
                if let footprintDisplayCell = summaryTableView.dequeueReusableCell(withIdentifier: FootprintDisplayCell.reuseIdentifier, for: indexPath) as? FootprintDisplayCell {
                    return footprintDisplayCell
                }
            } else if indexPath.row == 1 {
                if let graphCell = summaryTableView.dequeueReusableCell(withIdentifier: GraphDemoTableViewCell.reuseIdentifier, for: indexPath) as? GraphDemoTableViewCell {
                    return graphCell
                }
            }
        } else if indexPath.section == 1 {
            if let progressCell = summaryTableView.dequeueReusableCell(withIdentifier: CustomProgressTableViewCell.reuseIdentifier, for: indexPath) as? CustomProgressTableViewCell {
                
                if indexPath.row == 0 {
                    progressCell.customTitle = "Overall progress"
                    progressCell.customProgressDisclosure = "44"
                    progressCell.customDetailIcon = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))!
                    
                    return progressCell
                } else if indexPath.row == 1 {
                    progressCell.customTitle = "Goals completed"
                    progressCell.customProgressDisclosure = "7/10"
                    progressCell.customDetailIcon = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))!
                    
                    return progressCell
                }
            }
        }
        
        return UITableViewCell()
    }
}
