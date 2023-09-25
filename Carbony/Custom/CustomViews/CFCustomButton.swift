//
//  InitialLightButton.swift
//  Carbony
//
//  Created by doss-zstch1212 on 20/09/23.
//
/// Use this button across the app for reducing boilerplate code.
///  Make future customization here to make refactoring more easy.
///  :)

import Foundation
import UIKit

class CFCustomButton: UIButton {
    var customBackgroundColor: UIColor = UIColor(named: "CustomMainBackgroundColor") ?? UIColor.systemBackground {
        didSet {
            backgroundColor = customBackgroundColor
        }
    }
    
    var customTextColor: UIColor = UIColor.label {
        didSet {
            setTitleColor(customTextColor, for: .normal)
        }
    }
    
    var customFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .semibold) {
        didSet {
            titleLabel?.font = customFont
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // setting appearance
        backgroundColor = customBackgroundColor
        layer.cornerRadius = 8
        layer.borderWidth = 1
        //layer.borderColor = UIColor(red: 0.118, green: 0.137, blue: 0.173, alpha: 1).cgColor
        layer.borderColor = UIColor.label.cgColor
        setTitleColor(customTextColor, for: .normal)
        titleLabel?.font = customFont
    }
}
