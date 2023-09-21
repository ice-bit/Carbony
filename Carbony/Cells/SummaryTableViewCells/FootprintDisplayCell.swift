//
//  TableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 21/09/23.
//

import UIKit

class FootprintDisplayCell: UITableViewCell {
    static let reuseIdentifier: String = "FootprintDisplayCell"
    
    let carbonFootprintLabel: UILabel = {
        let label = UILabel()
        label.text = "9.41"
        label.font = UIFont.systemFont(ofSize: 64, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "ton of Co2/year"
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupLabel()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //setupLabel()
    }
    
    // MARK: - private methods
    private func setupLabel() {
        contentView.addSubview(carbonFootprintLabel)
        contentView.addSubview(unitLabel)
        
        NSLayoutConstraint.activate([
            // constraints for carbonFootprintLabel
            carbonFootprintLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            carbonFootprintLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            // constraints for unitLabel
            unitLabel.leadingAnchor.constraint(equalTo: carbonFootprintLabel.trailingAnchor, constant: 2),
            unitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }

}
