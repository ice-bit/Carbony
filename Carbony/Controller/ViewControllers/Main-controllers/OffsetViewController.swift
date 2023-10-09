//
//  OffsetViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 11/09/23.
//

import UIKit

class OffsetViewController: UIViewController {
    // MARK: - Properties
    let offsetTableView = UITableView()
    
    let carbonCreditCellData: [CarbonCreditCellModal] = [
        CarbonCreditCellModal(title: "Available Credits", progress: "0", iconName: "chevron.right", disclosureTitle: "Sell", targetLeftValue: "56"),
        CarbonCreditCellModal(title: "Required Credits", progress: "0", iconName: "chevron.right", disclosureTitle: "Buy", targetLeftValue: "44")
    ]
    
    // MARK: - Viewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopTableView()
        registerCells()
        offsetTableView.separatorStyle = .none
        offsetTableView.allowsSelection = false
        offsetTableView.dataSource = self
        offsetTableView.delegate = self
    }
    
    // registering cells in tableView
    private func registerCells() {
        offsetTableView.register(FootprintDisplayCell.self, forCellReuseIdentifier: FootprintDisplayCell.reuseIdentifier)
        offsetTableView.register(CCreditTableViewCell.self, forCellReuseIdentifier: CCreditTableViewCell.reuseIdentifier)
        offsetTableView.register(GraphDemoTableViewCell.self, forCellReuseIdentifier: GraphDemoTableViewCell.reuseIdentifier)
        offsetTableView.register(CFCustomButtonsCell.self, forCellReuseIdentifier: CFCustomButtonsCell.reuseIdentifier)
    }
    
    // MARK: - UI Setup and auto layouting methods
    private func setupTopTableView() {
        view.addSubview(offsetTableView)
        offsetTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            offsetTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            offsetTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            offsetTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            //offsetTopTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
            offsetTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - TableView delegate
extension OffsetViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let secOneHeader = CFTableViewSectionHeaderView()
            secOneHeader.customTitle = "Outstanding"
            secOneHeader.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
            return secOneHeader
        } else if section == 1 {
            let secTwoheader =  CFTableViewSectionHeaderView()
            secTwoheader.customTitle = "Carbon Credits"
            secTwoheader.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
            return secTwoheader
        } else if section == 2{
            let thridSecHeader = CFTableViewSectionHeaderView()
            thridSecHeader.customTitle = "Stats"
            thridSecHeader.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.92)
            return thridSecHeader
        }
        
        print("No view for header is fed?!")
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            // first cell height
            return 80
        } else if indexPath.section == 1 {
            return 84
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                return 262
            } else if indexPath.row == 1 {
                return 64
            }
        }
        return 0
    }
}

// MARK: - TableView datasource
extension OffsetViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 && indexPath.row == 0 {
            if let footprintCell = offsetTableView.dequeueReusableCell(withIdentifier: FootprintDisplayCell.reuseIdentifier, for: indexPath) as? FootprintDisplayCell {
                footprintCell.customTitleValue = "345"
                
                return footprintCell
            }
        } else if indexPath.section == 1 {
            let carbonCreditData = carbonCreditCellData[indexPath.row]
            if let carbonCreditCell = offsetTableView.dequeueReusableCell(withIdentifier: CCreditTableViewCell.reuseIdentifier, for: indexPath) as? CCreditTableViewCell {
                carbonCreditCell.customTitle = carbonCreditData.title
                carbonCreditCell.customDisclosureTitle = carbonCreditData.disclosureTitle
                carbonCreditCell.customTargetLeft = carbonCreditData.targetLeftValue
                carbonCreditCell.customProgressDisclosure = carbonCreditData.progress
                carbonCreditCell.customDetailIcon = UIImage(systemName: carbonCreditData.iconName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))!
                
                return carbonCreditCell
            }
        } else if indexPath.section == 2{
            if indexPath.row == 0 {
                if let graphTemplateCell = offsetTableView.dequeueReusableCell(withIdentifier: GraphDemoTableViewCell.reuseIdentifier, for: indexPath) as? GraphDemoTableViewCell {
                    return graphTemplateCell
                }
            } else if indexPath.row == 1 {
                if let tradeButtonCell = offsetTableView.dequeueReusableCell(withIdentifier: CFCustomButtonsCell.reuseIdentifier, for: indexPath) as? CFCustomButtonsCell {
                    tradeButtonCell.customLightButtonTitle = "Sell"
                    tradeButtonCell.customDarkButtonTitle = "Buy"
                    return tradeButtonCell
                }
            }
        }
        
        return UITableViewCell()
    }
    
    
}
