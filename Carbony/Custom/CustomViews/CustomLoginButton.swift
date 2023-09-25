//
//  Login.swift
//  Carbony
//
//  Created by doss-zstch1212 on 04/08/23.
//

import UIKit

class CustomLoginButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        self.backgroundColor = UIColor(red: 0.118, green: 0.137, blue: 0.173, alpha: 1)
        self.layer.cornerRadius = 8
    }
}
