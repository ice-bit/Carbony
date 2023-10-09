//
//  SummaryViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 16/08/23.
//
/// Warning once only: UITableView was told to layout its visible cells and other contents without being in the view hierarchy (the table view or one of its superviews has not been added to a window). This may cause bugs by forcing views inside the table view to load and perform layout without accurate information (e.g. table view bounds, trait collection, layout margins, safe area insets, etc), and will also cause unnecessary performance overhead due to extra layout passes. Make a symbolic breakpoint at UITableViewAlertForLayoutOutsideViewHierarchy to catch this in the debugger and see what caused this to occur, so you can avoid this action altogether if possible, or defer it until the table view has been added to a window. Table view: <UITableView: 0x152045400; frame = (0 103; 393 666); clipsToBounds = YES; autoresize = RM+BM; gestureRecognizers = <NSArray: 0x600002e984b0>; backgroundColor = <UIDynamicSystemColor: 0x6000035a0f80; name = tableBackgroundColor>; layer = <CALayer: 0x6000020a5f80>; contentOffset: {0, 1}; contentSize: {393, 540}; adjustedContentInset: {0, 0, 0, 0}; dataSource: <Carbony.GoalViewController: 0x14fd19b30>>

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
        DBController.shared.getTotalFootprint { incomingEmission in
            print(incomingEmission)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        summaryTableView.reloadData()
    }
    
    // MARK: - OBJC methods
    
    // MARK: - private methods
    func getPercentageProgress() -> Int {
        var percentageProgress: Int = 0
        DBController.shared.fetchGoalsCounts { totalGoalsCount, completedGoalCount in
            let percentage = min((Double(completedGoalCount) / Double(totalGoalsCount)) * 100, 100)
            let clampedPercentage = max(percentage, 0)
            let roundedPercentage = Int(clampedPercentage)
            percentageProgress = roundedPercentage
        }
        
        return percentageProgress
    }
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
                    let footprintText = UserDefaults.standard.double(forKey: "totalFootprint")
                    footprintDisplayCell.customTitleValue = String(footprintText)
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
                    let progress = getPercentageProgress()
                    progressCell.customTitle = "Overall progress"
                    progressCell.progressLabel.text = "\(progress)%"
                    progressCell.customDetailIcon = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))!
                    
                    return progressCell
                } else if indexPath.row == 1 {
                    progressCell.customTitle = "Goals completed"
                    DBController.shared.fetchGoalsCounts { totalGoalsCount, completedGoalsCount in
                        DispatchQueue.main.async {
                            progressCell.progressLabel.text = "\(completedGoalsCount)/\(totalGoalsCount)"
                        }
                    }
                    progressCell.customDetailIcon = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))!
                    
                    return progressCell
                }
            }
        }
        
        return UITableViewCell()
    }
}
