//
//  ImageDownloaderOperation.swift
//  ChartFive
//
//  Created by Anuj Kumar on 1/10/19.
//  Copyright © 2019 Pavel Bogart. All rights reserved.
//

import UIKit

enum ImageDownloadError: Error {
  case downloadFailed
}

class ImageDownloaderOperation: Operation {
  //1
  let url: String
  var image: UIImage?
  var error: ImageDownloadError?

  //2
  init(_ url: String) {
    self.url = url
  }

  //3
  override func main() {
    //4
    if isCancelled {
      return
    }

    guard let url = URL(string: url) else { return }

    //5
    guard let imageData = try? Data(contentsOf: url) else { return }

    //6
    if isCancelled {
      return
    }

    //7
    if !imageData.isEmpty {
      image = UIImage(data:imageData)
    } else {
      error = .downloadFailed
    }
  }
}
