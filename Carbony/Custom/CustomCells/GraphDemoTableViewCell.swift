//
//  GraphDemoTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 21/09/23.
//

import UIKit

class GraphDemoTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "GraphDemoTableViewCell"
    
    let graphView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomMainBackgroundColor")!
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
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
    
    private func setupUI() {
        contentView.addSubview(graphView)
        
        NSLayoutConstraint.activate([
            graphView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            graphView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            graphView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            graphView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

}
