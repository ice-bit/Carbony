//
//  FootprintTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 03/10/23.
//

import UIKit

class FootprintTableViewCell: UITableViewCell {
    // MARK: - Proeprties
    static let reuseIdentifier: String = "FootprintTableViewCell"
    
    // MARK: - UI elements
    let contentWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomMainBackgroundColor")
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Type"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emissionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "1343.23"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emissionUnitLabel: UILabel = {
        let label = UILabel()
        label.text = "tons of Co2"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Default methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
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
    
    // MARK: - Private methods
    private func setupCellUI() {
        contentView.addSubview(contentWrapper)
        contentWrapper.addSubview(typeLabel)
        contentWrapper.addSubview(emissionLabel)
        contentWrapper.addSubview(emissionUnitLabel)
        contentWrapper.addSubview(dateLabel)
        
        
        NSLayoutConstraint.activate([
            contentWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            contentWrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            // typeLabel constraints
            typeLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            typeLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 8),
            // emissionLabel
            emissionLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            emissionLabel.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8),
            // emissionUnitLabel
            emissionUnitLabel.leadingAnchor.constraint(equalTo: emissionLabel.trailingAnchor, constant: 2),
            emissionUnitLabel.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -12),
            // dateLabel constraints
            dateLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8)
        ])
    }
    
    // Public methods
    public func updateCell(with footprint: CarbonFootprint) {
        let emissionStringValue = String(footprint.emissionValue)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateLabel.text = dateFormatter.string(from: footprint.date)
        emissionLabel.text = emissionStringValue
        typeLabel.text = footprint.footprintType
        
    }

}
