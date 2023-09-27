//
//  CalculateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 05/09/23.
//

import UIKit

class CalculateViewController: UIViewController {
    // MARK: Properties
    let calculateTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var selectedSegmentIndex: Int = 0 // Default value of segment
    
    // MARK: - ViewController lifecylce methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calculate Footprint"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupCancelButton()
       // setupAndActivateContraints()
        setupAndConstraintTableView()
        registerCells()
        
        calculateTableView.delegate = self
        calculateTableView.dataSource = self
    }
    
    // MARK: - OBJC methods
    @objc private func cancelBarButtonAction() {
        self.dismiss(animated: true)
    }
    
    // MARK: - Private methods
    private func setupCancelButton() {
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBarButtonAction))
        self.navigationItem.leftBarButtonItem = cancelBarButton
    }
    
    private func registerCells() {
        calculateTableView.register(FootprintDisplayCell.self, forCellReuseIdentifier: FootprintDisplayCell.reuseIdentifier)
        calculateTableView.register(CalculateInputTableViewCell.self, forCellReuseIdentifier: CalculateInputTableViewCell.reuseIdentifier)
        calculateTableView.register(TypeSelectionTableViewCell.self, forCellReuseIdentifier: TypeSelectionTableViewCell.reuseIdentifier)
        calculateTableView.register(CFCustomButtonsCell.self, forCellReuseIdentifier: CFCustomButtonsCell.reuseIdentifier)
    }
    
    private func setupAndConstraintTableView() {
        view.addSubview(calculateTableView)
        
        NSLayoutConstraint.activate([
            calculateTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            calculateTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            calculateTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            calculateTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - TableView delegate
extension CalculateViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            // Footprint display cell height
            return 64
        } else if indexPath.section == 1 {
            // segment controller cell height
            return 70
        } else if indexPath.section == 2 {
            // Text field cell height
            return 57
        } else if indexPath.section == 3 {
            // Button cell height
            return 100
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - TableView Datasource
extension CalculateViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section == 2 else { return 1 }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let footprintHeaderViewCell = calculateTableView.dequeueReusableCell(withIdentifier: FootprintDisplayCell.reuseIdentifier, for: indexPath) as? FootprintDisplayCell {
                footprintHeaderViewCell.customTitleValue = "786"
//                footprintHeaderViewCell.backgroundColor = .systemPink
                return footprintHeaderViewCell
            }
        } else if indexPath.section == 1 {
            if let typeSelectionCell = calculateTableView.dequeueReusableCell(withIdentifier: TypeSelectionTableViewCell.reuseIdentifier, for: indexPath) as? TypeSelectionTableViewCell {
                typeSelectionCell.segmentDelegate = self
                return typeSelectionCell
            }
        } else if indexPath.section == 2 {
            if let inputCell = calculateTableView.dequeueReusableCell(withIdentifier: CalculateInputTableViewCell.reuseIdentifier, for: indexPath) as? CalculateInputTableViewCell {
                if indexPath.row == 0 {
                    if selectedSegmentIndex == 0 {
                        inputCell.inputTextField.placeholder = "Distance"
                    } else if selectedSegmentIndex == 1 {
                        inputCell.inputTextField.placeholder = "KWh"
                    }
                    
                    
                } else if indexPath.row == 1 {
                    inputCell.inputTextField.placeholder = "Vechicle Efficiency"
                    inputCell.inputTextField.placeholder = "Source"
                }
                
                return inputCell
            }
        } else if indexPath.section == 3 {
            if let calculateButtonsCell = calculateTableView.dequeueReusableCell(withIdentifier: CFCustomButtonsCell.reuseIdentifier, for: indexPath) as? CFCustomButtonsCell {
                calculateButtonsCell.customLightButtonTitle = "Calculate"
                calculateButtonsCell.customDarkButtonTitle = "Add"
                return calculateButtonsCell
            }
        }
        
        return UITableViewCell()
    }
}

extension CalculateViewController: TypeSelectionSegmentControlDelegate {
    func segmentControlDidChangeSelction(_ segmentControl: UISegmentedControl) {
        selectedSegmentIndex = segmentControl.selectedSegmentIndex
        calculateTableView.reloadSections(IndexSet(integer: 2), with: .automatic)
    }
    
    
}
