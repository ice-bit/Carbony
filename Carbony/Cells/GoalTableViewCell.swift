//
//  GoalTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 18/08/23.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    @IBOutlet weak var goalContentView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var targetLeftLabel: UILabel!
    
    let customDisclosureButton = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
    }
    
    private func setupUI() {
        let disclosureImage = UIImage(systemName: "chevron.right")
        customDisclosureButton.setImage(disclosureImage, for: .normal)
        customDisclosureButton.tintColor = UIColor.label
        customDisclosureButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        goalContentView.addSubview(customDisclosureButton)
        customDisclosureButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            customDisclosureButton.topAnchor.constraint(equalTo: goalContentView.topAnchor, constant: 8),
            customDisclosureButton.trailingAnchor.constraint(equalTo: goalContentView.trailingAnchor, constant: -8)
        ])
        
        
        // goalContentView cornerRadius and other styling
        goalContentView.layer.cornerRadius = 8
        goalContentView.layer.borderWidth = 1
        goalContentView.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
//        goalContentView.layer.backgroundColor = UIColor(red: 0.969, green: 0.973, blue: 0.976, alpha: 1).cgColor
    }
    
    func updateCell(withGoal goal: Goal) {
        self.descriptionLabel.text = goal.description
        self.progressLabel.text = String(goal.progress)
        self.targetLeftLabel.text = String(goal.targetLeft)
    }
}
