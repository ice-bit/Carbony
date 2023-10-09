//
//  CalculateViewController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 05/09/23.
//

import UIKit
protocol DataReloadDelegate {
    func reloadGoalData()
    func reloadFootprintData()
}
class CalculateViewController: UIViewController {
    // MARK: - Properties
    var reloadDelegate: DataReloadDelegate?
    
    let calculateTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let carbonFootprintController = CarbonFootprintController()
    
    let typeValues: [String] = ["Coal", "Natural gas", "Nuclear"]
    
    var selectedSegmentIndex: Int = 0 // Default value of segment
    
    let transportPlaceholderTexts: [String] = ["Distance", "Vehicle Effiencey", "Frequency"]
    let electricityPlaceholderTexts: [String] = ["KWh", "Source"]
    
    var transportInputs: [String: Double] = [:]
    var electricityInputs: [String: Double] = [:]
    
    // MARK: - ViewController lifecylce methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Calculate Footprint"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupCancelButton()
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
    
    private func AddFootprintToDataBase(for input: [String: Double]) {
        var emissionValue: Double = 0.0
        
        if selectedSegmentIndex == 0 {
            guard let distance = input["Distance"], let fuelEfficiency = input["Vehicle Effiencey"], let frequency = input["Frequency"] else {
                return
            }
            
            emissionValue = carbonFootprintController.calculateDrivingEmission(distance: distance, fuelEfficiency: fuelEfficiency, frequency: Int(frequency), emissionFactor: 4.6)
            let carbonFootprint = CarbonFootprint(uuid: UUID(), emissionValue: emissionValue, footprintType: "Transport", date: Date())
            
            DBController.shared.insertIntoFootprintTable(uuid: carbonFootprint.uuid, emissioValue: carbonFootprint.emissionValue, footprintType: carbonFootprint.footprintType, date: carbonFootprint.date)
            DBController.shared.printFootprintTableRows()
        } else if selectedSegmentIndex == 1 {
            guard let KWh = input["KWh"] else {
                return
            }
            
            emissionValue = carbonFootprintController.calculateElectricityEmission(electricityConsumedKWh: KWh, electricitySource: ElectricitySource.coal)
            let carbonFootprint = CarbonFootprint(uuid: UUID(), emissionValue: emissionValue, footprintType: "Electrictiy", date: Date())
            
            DBController.shared.insertIntoFootprintTable(uuid: carbonFootprint.uuid, emissioValue: carbonFootprint.emissionValue, footprintType: carbonFootprint.footprintType, date: carbonFootprint.date)
            DBController.shared.printFootprintTableRows()
        }
        
        self.dismiss(animated: true) {
            self.reloadDelegate?.reloadFootprintData()
        }
        /*carbonFootprintController.updateTotalFootprint(with: emissionValue)
        print("Total footprint: \(UserDefaults.standard.double(forKey: "totalFootprint"))")*/
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
        
        if selectedSegmentIndex == 0 {
            return 3
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let footprintHeaderViewCell = calculateTableView.dequeueReusableCell(withIdentifier: FootprintDisplayCell.reuseIdentifier, for: indexPath) as? FootprintDisplayCell {
                footprintHeaderViewCell.customTitleValue = "786"
                return footprintHeaderViewCell
            }
        } else if indexPath.section == 1 {
            if let typeSelectionCell = calculateTableView.dequeueReusableCell(withIdentifier: TypeSelectionTableViewCell.reuseIdentifier, for: indexPath) as? TypeSelectionTableViewCell {
                typeSelectionCell.segmentDelegate = self
                return typeSelectionCell
            }
        } else if indexPath.section == 2 {
            if let inputCell = calculateTableView.dequeueReusableCell(withIdentifier: CalculateInputTableViewCell.reuseIdentifier, for: indexPath) as? CalculateInputTableViewCell {
                if selectedSegmentIndex == 0 {
                    let placeholderData = transportPlaceholderTexts[indexPath.row]
                    inputCell.inputTextField.placeholder = placeholderData
                } else {
                    let placeholderData = electricityPlaceholderTexts[indexPath.row]
                    inputCell.inputTextField.placeholder = placeholderData
                }
                return inputCell
            }
        } else if indexPath.section == 3 {
            if let calculateButtonsCell = calculateTableView.dequeueReusableCell(withIdentifier: CFCustomButtonsCell.reuseIdentifier, for: indexPath) as? CFCustomButtonsCell {
                calculateButtonsCell.cfButtonDelegate = self
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

extension CalculateViewController: CFCustomButtonCellDelegate {
    // Action for calculate button
    func didTappedLightButton() {
        
    }
    
    // Action for add footprint button
    func didTappedDarkButton() {
        if selectedSegmentIndex == 0 {
            fetchTransportInputs()
            
        } else if selectedSegmentIndex == 1 {
            fetchElectircityInput()
        }
    }
    
    private func fetchElectircityInput() {
        if let inputCell = calculateTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? CalculateInputTableViewCell {
            guard inputCell.inputTextField.text != nil else {
                showAlert(title: "No values found", message: "Enter values into the text field") {
                    self.dismiss(animated: true)
                }
                return
            }
            
            if let inputText = inputCell.inputTextField.text,
               let placeholderText = inputCell.inputTextField.placeholder,
               let input = Double(inputText) {
                print("\(placeholderText): \(input)")
                electricityInputs[placeholderText] = input
            } else {
                showAlert(title: "Invalid input", message: "Try to enter a valid input") {
                    self.dismiss(animated: true)
                }
                print("Failed to convert the input values")
            }
        }
        
        AddFootprintToDataBase(for: electricityInputs)
    }
    
    private func fetchTransportInputs() {
        for index in 0..<3 {
            if let inputCell = calculateTableView.cellForRow(at: IndexPath(row: index, section: 2)) as? CalculateInputTableViewCell {
                guard inputCell.inputTextField.text != nil else {
                    showAlert(title: "No values found", message: "Enter values into the text field") {
                        self.dismiss(animated: true)
                    }
                    return
                }
                
                if let inputText = inputCell.inputTextField.text,
                   let placeholderText = inputCell.inputTextField.placeholder,
                   let input = Double(inputText) {
                    //print("\(placeholderText): \(input)")
                    transportInputs[placeholderText] = input
                } else {
                    showAlert(title: "Invalid input", message: "Try to enter a valid input") {
                        self.dismiss(animated: true)
                    }
                    print("Failed to convert the input values")
                }
            }
        }
        
        AddFootprintToDataBase(for: transportInputs)
    }
}
