//
//  CFTextField.swift
//  Carbony
//
//  Created by doss-zstch1212 on 20/09/23.
//

import Foundation
import UIKit

class CFTextField: UITextField {
    let padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCFTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCFTextField()
    }
    
    // setup the textField UI
    private func setupCFTextField() {
        // set placeholder color
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [.foregroundColor: UIColor.lightGray])
        
        // customize appearance
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        layer.cornerRadius = 8
        backgroundColor = UIColor(named: "CustomMainBackgroundColor") ?? UIColor.systemGray6
        
        // add left padding to the placeholder
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding.left, height: 1))
        leftViewMode = .always
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
