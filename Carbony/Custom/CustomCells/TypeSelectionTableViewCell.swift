//
//  TypeSelectionTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 26/09/23.
//

import UIKit

protocol TypeSelectionSegmentControlDelegate {
    func segmentControlDidChangeSelction(_ segmentControl: UISegmentedControl)
}

class TypeSelectionTableViewCell: UITableViewCell {
    static let reuseIdentifier: String  = "TypeSelectionTableViewCell"
    
    var segmentDelegate: TypeSelectionSegmentControlDelegate?
    
    let typeSegmentController: UISegmentedControl = {
        let segmentController = UISegmentedControl(items: ["Transport", "Electricity"])
        segmentController.selectedSegmentIndex = 0
        segmentController.translatesAutoresizingMaskIntoConstraints = false
        return segmentController
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAndConstaintSegmentController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setupAndConstaintSegmentController() {
        contentView.addSubview(typeSegmentController)
        
        NSLayoutConstraint.activate([
            typeSegmentController.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            typeSegmentController.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor),
            typeSegmentController.widthAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            typeSegmentController.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        typeSegmentController.addTarget(self, action: #selector(segmentedControlValueChanged(_ :)), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        print("Selected segment index \(sender.selectedSegmentIndex): \(sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "")")
        segmentDelegate?.segmentControlDidChangeSelction(sender)
    }
}
