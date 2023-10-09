//
//  CalculateInputTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 25/09/23.
//

import UIKit

class CalculateInputTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "CalculateInputTableViewCell"
    
    var customPlaceholderText: String = "" {
        didSet {
            inputTextField.text = customPlaceholderText
        }
    }
    
    let inputTextField: CFTextField = {
        let textField = CFTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupTextField() {
        contentView.addSubview(inputTextField)
        
        NSLayoutConstraint.activate([
            inputTextField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 49),
            inputTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            inputTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
