//
//  DetailViewController.swift
//  ChartFive
//
//  Created by Anuj Kumar on 12/16/18.
//  Copyright © 2018 Pavel Bogart. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var titleLabel: UILabel!
  
  init(title: String?) {
    super.init(nibName: nil, bundle: nil)
    self.title = title
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red
    titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.backgroundColor = .blue
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(titleLabel)
    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      ])
  }
}
