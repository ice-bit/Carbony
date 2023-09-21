//
//  SummaryProgressSecHeaderView.swift
//  Carbony
//
//  Created by doss-zstch1212 on 21/09/23.
//

import Foundation
import UIKit

class SummaryTableSecHeaderView: UIView {
    var customTitle: String = "Title" {
        didSet {
            titleLabel.text = customTitle
        }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupHeaderUI()
    }
    
    // Header UI setup method
    private func setupHeaderUI() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
