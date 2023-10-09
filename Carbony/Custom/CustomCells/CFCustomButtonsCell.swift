//
//  CarbonTradeCellTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 24/09/23.
//

import UIKit

protocol CFCustomButtonCellDelegate {
    func didTappedLightButton()
    func didTappedDarkButton()
}

class CFCustomButtonsCell: UITableViewCell {
    static let reuseIdentifier: String = "CarbonTradeCellTableViewCell"
    
    var cfButtonDelegate: CFCustomButtonCellDelegate?
    
    var customLightButtonTitle: String = "" {
        didSet {
            lightButton.setTitle(customLightButtonTitle, for: .normal)
        }
    }
    
    var customDarkButtonTitle: String = "" {
        didSet {
            darkbutton.setTitle(customDarkButtonTitle, for: .normal)
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
    
    let darkbutton: CFCustomButton = {
        let buyButton = CFCustomButton()
        buyButton.customBackgroundColor = .label
        buyButton.customTextColor = .systemBackground
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        return buyButton
    }()
    
    let lightButton: CFCustomButton = {
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
        sellButtonWrapper.addSubview(lightButton)
        buyButtonWrapper.addSubview(darkbutton)
        
        NSLayoutConstraint.activate([
            sellButtonWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            sellButtonWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            sellButtonWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            sellButtonWrapper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            buyButtonWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            buyButtonWrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            buyButtonWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            buyButtonWrapper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            lightButton.heightAnchor.constraint(equalToConstant: 49),
            lightButton.widthAnchor.constraint(equalTo: sellButtonWrapper.widthAnchor, multiplier: 0.8),
            lightButton.centerXAnchor.constraint(equalTo: sellButtonWrapper.centerXAnchor),
            lightButton.centerYAnchor.constraint(equalTo: sellButtonWrapper.centerYAnchor),
            
            darkbutton.heightAnchor.constraint(equalToConstant: 49),
            darkbutton.widthAnchor.constraint(equalTo: buyButtonWrapper.widthAnchor, multiplier: 0.85),
            darkbutton.centerXAnchor.constraint(equalTo: buyButtonWrapper.centerXAnchor),
            darkbutton.centerYAnchor.constraint(equalTo: buyButtonWrapper.centerYAnchor),
        ])
        
        lightButton.addTarget(self, action: #selector(sellButtonAction(_ :)), for: .touchUpInside)
        darkbutton.addTarget(self, action: #selector(buyButtonAction(_ :)), for: .touchUpInside)
    }
    
    @objc func sellButtonAction(_ sender: UIButton) {
        print("Light button tapped")
        cfButtonDelegate?.didTappedLightButton()
    }
    
    @objc func buyButtonAction(_ sender: UIButton) {
        print("Dark button tapped")
        cfButtonDelegate?.didTappedDarkButton()
    }

}
