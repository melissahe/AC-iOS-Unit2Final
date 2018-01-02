//
//  CrayonTableViewCell.swift
//  AC-iOS-Unit2Final
//
//  Created by C4Q on 11/10/17.
//  Copyright © 2017 Karen Fuentes. All rights reserved.
//

import UIKit

class CrayonTableViewCell: UITableViewCell {

    var colorNameLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
        label.textAlignment = .center
        
        return label
    }()
    
    var crayonImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "transparentCrayon")
        
        return imageView
    }()
    
    var decimalHexLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium)
        label.setContentHuggingPriority(UILayoutPriority(250), for: .vertical)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(colorNameLabel)
        self.contentView.addSubview(crayonImageView)
        self.contentView.addSubview(decimalHexLabel)

        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        colorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        colorNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        colorNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
       colorNameLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true

        crayonImageView.translatesAutoresizingMaskIntoConstraints = false
        crayonImageView.topAnchor.constraint(equalTo: colorNameLabel.bottomAnchor, constant: 10).isActive = true
       crayonImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 40).isActive = true
        crayonImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -40).isActive = true
        crayonImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 49)
        
        decimalHexLabel.translatesAutoresizingMaskIntoConstraints = false
        decimalHexLabel.topAnchor.constraint(equalTo: crayonImageView.bottomAnchor, constant: 10).isActive = true
        decimalHexLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 8).isActive = true
        decimalHexLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -8).isActive = true
        decimalHexLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -13.5).isActive = true
        
    }
    
    func configureCell(withColorName colorName: String, textColor: UIColor, backgroundColor: UIColor, andDecimalHexText decimalHexText: String) {
        self.colorNameLabel.text = colorName
        self.colorNameLabel.textColor = textColor
        self.decimalHexLabel.text = decimalHexText
        self.decimalHexLabel.textColor = textColor
        self.contentView.backgroundColor = backgroundColor
    }
    
}
