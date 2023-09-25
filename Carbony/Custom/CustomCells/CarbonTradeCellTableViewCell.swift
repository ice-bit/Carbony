//
//  CarbonTradeCellTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 24/09/23.
//

import UIKit

class CarbonTradeCellTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "CarbonTradeCellTableViewCell"
    
    let sellButtonWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let buyButtonWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupButtons()
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
    
    private func setupButtons() {
        let sellButton = CFCustomButton()
        sellButton.setTitle("Sell", for: .normal)
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        
        let buyButton = CFCustomButton()
        buyButton.setTitle("Buy", for: .normal)
        buyButton.customBackgroundColor = .label
        buyButton.customTextColor = .systemBackground
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(sellButtonWrapper)
        contentView.addSubview(buyButtonWrapper)
        sellButtonWrapper.addSubview(sellButton)
        buyButtonWrapper.addSubview(buyButton)
        
        NSLayoutConstraint.activate([
            sellButtonWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            sellButtonWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            sellButtonWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            sellButtonWrapper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            buyButtonWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            buyButtonWrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            buyButtonWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            buyButtonWrapper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            sellButton.heightAnchor.constraint(equalToConstant: 49),
            sellButton.widthAnchor.constraint(equalTo: sellButtonWrapper.widthAnchor, multiplier: 0.8),
            sellButton.centerXAnchor.constraint(equalTo: sellButtonWrapper.centerXAnchor),
            sellButton.centerYAnchor.constraint(equalTo: sellButtonWrapper.centerYAnchor),
            
            buyButton.heightAnchor.constraint(equalToConstant: 49),
            buyButton.widthAnchor.constraint(equalTo: buyButtonWrapper.widthAnchor, multiplier: 0.85),
            buyButton.centerXAnchor.constraint(equalTo: buyButtonWrapper.centerXAnchor),
            buyButton.centerYAnchor.constraint(equalTo: buyButtonWrapper.centerYAnchor),
        ])
    }

}
