//
//  ViewController.swift
//  ChartFive
//
//  Created by Pavel Bogart on 3/10/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.estimatedRowHeight = 60.0
    tableView.rowHeight = UITableViewAutomaticDimension
    return tableView
  }()
  
  let bandCellId = "bandCellId"
  
  let bandsArray = [Info(image: "metallica", title: "Metallica"),
                    Info(image: "slipknot", title: "Slipknot"),
                    Info(image: "nirvana", title: "Nirvana"),
                    Info(image: "acdc", title: "AC/DC"),
                    Info(image: "system", title: "System Of A Down")]
  
  let songsArray = [Info(image: "1", title: "The Unforgiven"),
                    Info(image: "2", title: "Snuff"),
                    Info(image: "3", title: "Smells Like Teen Spirit"),
                    Info(image: "4", title: "Back In Black"),
                    Info(image: "5", title: "Chop Suey")]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTableView()
  }

  override func viewDidAppear(_ animated: Bool) {
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func setupViews() {
    navigationItem.title = "ChartFive"
    navigationController?.navigationBar.barTintColor = UIColor(r: 0, g: 255, b: 198)
    
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray,
                                                               NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
  }
  
  func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(BandTableViewCell.self, forCellReuseIdentifier: bandCellId)

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
      ])
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      return songsArray.count
    }
    return bandsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: bandCellId, for: indexPath) as! BandTableViewCell
    cell.pictureImageView.image = UIImage(named: bandsArray[indexPath.item].image!)
    cell.titleLabel.text = bandsArray[indexPath.item].title
    
    if indexPath.section == 1 {
      cell.pictureImageView.image = UIImage(named: songsArray[indexPath.item].image!)
      cell.titleLabel.text = songsArray[indexPath.item].title
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var title = bandsArray[indexPath.item].title
    if indexPath.section == 1 {
      title = songsArray[indexPath.item].title
    }
    navigationController?.pushViewController(DetailViewController(title: title), animated: true)
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 1 {
      return "Top Songs"
    }
    return "Top Bands"
  }
  
}
