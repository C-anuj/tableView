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
  var pendingOperations = [String: Operation]()
  var pendingOperationsQueue = OperationQueue()
  
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
    var model: Info = BandsModel.bandsArray[indexPath.item]
    infoModel = model
    var urlString = BandsModel.bandsArray[indexPath.item].image!
    titleLabel.text = BandsModel.bandsArray[indexPath.item].title

    if indexPath.section == 1 {
      model = BandsModel.songsArray[indexPath.item]
      urlString = BandsModel.songsArray[indexPath.item].image!
      titleLabel.text = BandsModel.songsArray[indexPath.item].title
    }

    let urlNSString: NSString = urlString as NSString
    if let image = BandTableViewCell.cache.object(forKey: urlNSString) {
      print("indexPath = \(indexPath), using cached image = \(image),  url = \(urlNSString)")
      pictureImageView.image = image
      return
    }
    startDownload(for: model) { image, downloadedUrlString in
      guard downloadedUrlString == urlString else { return }
      BandTableViewCell.cache.setObject(image, forKey: urlNSString)
      print("indexPath = \(indexPath), caching image = \(String(describing: image)),  url = \(urlString)")
      DispatchQueue.main.async { [weak self] in
        self?.pictureImageView.image = image
      }
    }
  }

  func startDownload(for model: Info, completion: @escaping (UIImage, String) -> Void) {
    guard let urlString = model.image else { return }
    if pendingOperations[urlString] != nil { return }

    let downloader = ImageDownloaderOperation(urlString)

    pendingOperations[urlString] = downloader

    downloader.completionBlock = {
      if downloader.isCancelled {
        return
      }
      guard let image = downloader.image else { return }

      DispatchQueue.main.async { [weak self] in
        completion(image, urlString)
        self?.pendingOperations[urlString] = nil
      }
    }
    pendingOperationsQueue.addOperation(downloader)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
