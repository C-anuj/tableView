//
//  BandTableViewCell.swift
//  ChartFive
//
//  Created by Anuj Kumar on 12/16/18.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class BandTableViewCell: UITableViewCell {

  static var cache: NSCache<NSString, UIImage> = NSCache()
  var infoModel: Info?
  
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
    BandTableViewCell.cache.countLimit = 200
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

  func populateCell(for indexPath: IndexPath) {
    let model: Info = BandsModel.bandsArray[indexPath.item]
    infoModel = model
    var urlString = BandsModel.bandsArray[indexPath.item].image!
    titleLabel.text = BandsModel.bandsArray[indexPath.item].title

    if indexPath.section == 1 {
      urlString = BandsModel.songsArray[indexPath.item].image!
      titleLabel.text = BandsModel.songsArray[indexPath.item].title
    }

    let session = URLSession(configuration: URLSessionConfiguration.default)
    let urlNSString: NSString = urlString as NSString
    if let image = BandTableViewCell.cache.object(forKey: urlNSString) {
      print("indexPath = \(indexPath), using cached image = \(image),  url = \(urlNSString)")
      pictureImageView.image = image
      return
    }
    let url = URL(string: urlString)
    let dataTask = session.dataTask(with: url!) {  [weak self] (data, response, error) in
      guard let infoModel = self?.infoModel else { return }
      guard model == infoModel else { return }
      guard let data = data else { return }
      let image = UIImage(data: data)
      let urlString: NSString = response!.url!.absoluteString as NSString
      BandTableViewCell.cache.setObject(image!, forKey: urlString)
      print("indexPath = \(indexPath), caching image = \(String(describing: image)),  url = \(urlString)")
      DispatchQueue.main.async { [weak self] in
        self?.pictureImageView.image = image
      }
    }
    dataTask.resume()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
