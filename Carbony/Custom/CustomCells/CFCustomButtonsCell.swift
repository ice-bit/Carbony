//
//  CarbonTradeCellTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 24/09/23.
//

import UIKit

class CFCustomButtonsCell: UITableViewCell {
    static let reuseIdentifier: String = "CarbonTradeCellTableViewCell"
    
    var customLightButtonTitle: String = "" {
        didSet {
            sellButton.setTitle(customLightButtonTitle, for: .normal)
        }
    }
    
    var customDarkButtonTitle: String = "" {
        didSet {
            buyButton.setTitle(customDarkButtonTitle, for: .normal)
        }
    }
    
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
    
    let buyButton: CFCustomButton = {
        let buyButton = CFCustomButton()
        buyButton.customBackgroundColor = .label
        buyButton.customTextColor = .systemBackground
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        return buyButton
    }()
    
    let sellButton: CFCustomButton = {
        let sellButton = CFCustomButton()
        sellButton.translatesAutoresizingMaskIntoConstraints = false
        return sellButton
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
