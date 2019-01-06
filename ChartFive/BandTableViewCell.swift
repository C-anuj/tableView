//
//  BandTableViewCell.swift
//  ChartFive
//
//  Created by Anuj Kumar on 12/16/18.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class BandTableViewCell: UITableViewCell {
  
  let pictureImageView: UIImageView = {
    let iv = UIImageView()
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Name"
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = UIColor.darkGray
    return label
  }()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  func setup() {
    backgroundColor = UIColor.white
    contentView.addSubview(pictureImageView)
    contentView.addSubview(titleLabel)
    
    pictureImageView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: safeTopAnchor),
      contentView.leadingAnchor.constraint(equalTo: safeLeadingAnchor),
      contentView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
      contentView.trailingAnchor.constraint(equalTo: safeTrailingAnchor),
      contentView.heightAnchor.constraint(
        greaterThanOrEqualTo: pictureImageView.heightAnchor, constant: 8),
      contentView.heightAnchor.constraint(
        greaterThanOrEqualTo: titleLabel.heightAnchor, constant: 8),
      
      pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
      pictureImageView.heightAnchor.constraint(equalToConstant: 40),
      pictureImageView.widthAnchor.constraint(equalToConstant: 40),
      pictureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      titleLabel.leadingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: 20),
      titleLabel.heightAnchor.constraint(equalToConstant: 40),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
      titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
