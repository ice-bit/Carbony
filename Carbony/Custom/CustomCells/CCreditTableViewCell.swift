//
//  CCreditTableViewCell.swift
//  Carbony
//
//  Created by doss-zstch1212 on 22/09/23.
//

import UIKit

class CCreditTableViewCell: UITableViewCell {
    static let reuseIdentifier: String = "CCreditTableViewCell"
    
    // MARK: - UIElements
    var customTitle: String = "Title" {
        didSet {
            titleLabel.text = customTitle
        }
    }
    
    var customProgressDisclosure: String = "941%" {
        didSet {
            progressLabel.text = customProgressDisclosure
        }
    }
    
    var customDetailIcon: UIImage = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))! {
        didSet {
            detailIcon.image = customDetailIcon
        }
    }
    
    var customDisclosureTitle: String = "" {
        didSet {
            disclosureTitleLabel.text = customDisclosureTitle
        }
    }
    
    var customTargetLeft: String = "" {
        didSet {
            CFLeftLabel.text = "\(customTargetLeft) of Co2 left"
        }
    }

    let contentWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "CustomMainBackgroundColor") ?? UIColor.lightGray
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.855, green: 0.855, blue: 0.855, alpha: 1).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let detailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let disclosureTitleLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textColor = .lightGray
        return lable
    }()
    
    let CFLeftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    // MARK: - private method to setup the cell
    private func setupCellUI() {
        contentView.addSubview(contentWrapper)
        contentWrapper.addSubview(titleLabel)
        contentWrapper.addSubview(progressLabel)
        contentWrapper.addSubview(detailIcon)
        contentWrapper.addSubview(disclosureTitleLabel)
        contentWrapper.addSubview(CFLeftLabel)
        
        NSLayoutConstraint.activate([
            // wrapper constraints
            contentWrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentWrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            contentWrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentWrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // titleLabel constraints
            titleLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 8),
            
            // progressLabel constraints
            progressLabel.leadingAnchor.constraint(equalTo: contentWrapper.leadingAnchor, constant: 8),
            progressLabel.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8),
            
            // detailIcon constraints
            detailIcon.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 8),
            detailIcon.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -8),
            
            // disclosureTitleLabel
            disclosureTitleLabel.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 12),
            disclosureTitleLabel.trailingAnchor.constraint(equalTo: detailIcon.leadingAnchor, constant: -2),
            
            // CFLeftLabel constraints
            CFLeftLabel.trailingAnchor.constraint(equalTo: contentWrapper.trailingAnchor, constant: -8),
            CFLeftLabel.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor, constant: -8)
        ])
    }

}
