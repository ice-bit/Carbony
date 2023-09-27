//
//  GoalSectionHeaderView.swift
//  Carbony
//
//  Created by doss-zstch1212 on 21/08/23.
//

import Foundation
import UIKit

protocol GoalSectionHeaderViewDelegate: AnyObject {
    func addButtonTapped(inSection section: Int)
    func toggleButtonTapped(inSection section: Int)
}

class GoalSectionHeaderView: UIView {
    
    weak var delegate: GoalSectionHeaderViewDelegate?
    
    /*var isExpanded: Bool = false
    var isToggleCellButtonTapped = false {
        didSet {
            toggleCellVisibilityButton.setImage(isToggleCellButtonTapped ? tappedToggleImage : initialToggleImage, for: .normal)
        }
    }
    
    let initialToggleImage = UIImage(systemName: "chevron.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
    let tappedToggleImage = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))*/

    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Goals"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let toggleCellVisibilityButton: UIButton = {
        let button = UIButton()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
        button.setImage(UIImage(systemName: "chevron.up", withConfiguration: symbolConfiguration), for: .normal)
        button.tintColor = UIColor.label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let headerAddButton: UIButton = {
        let button = UIButton()
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 33)
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: symbolConfiguration), for: .normal)
        button.tintColor = UIColor.label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeaderUI()
    }
    
    private func setupHeaderUI() {
        addSubview(headerLabel)
        addSubview(headerAddButton)
        addSubview(toggleCellVisibilityButton)
        
        NSLayoutConstraint.activate([
            // headerLabel contraints
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            // header button constraints
            headerAddButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            headerAddButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            // toggleCell button constraints
            toggleCellVisibilityButton.leadingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: 8),
            toggleCellVisibilityButton.topAnchor.constraint(equalTo: topAnchor, constant: 16)
        ])
    
        headerAddButton.addTarget(self, action: #selector(addGoalButtonTapped), for: .touchUpInside)
        toggleCellVisibilityButton.addTarget(self, action: #selector(toggleCellButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addGoalButtonTapped() {
        print("Button tapped: \(headerAddButton.titleLabel?.text ?? "headerAddButton")")
        delegate?.addButtonTapped(inSection: tag)
    }
    
    @objc private func toggleCellButtonTapped() {
        print("Button tapped: \(toggleCellVisibilityButton.titleLabel?.text ?? "ToggleCellVisibility ")")
        //isToggleCellButtonTapped.toggle()
        delegate?.toggleButtonTapped(inSection: tag)
    }
    
    /*private func updateToggleCellButtonImage() {
        isExpanded.toggle()
        let imageName = isExpanded ? "chevron.up" : "chevron.down"
        let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 18)
        let image = UIImage(systemName: imageName, withConfiguration: symbolConfiguration)
        toggleCellVisibilityButton.setImage(image, for: .normal)
        print("Minimin's sister is really cool")
    }*/
}
