//
//  ViewController.swift
//  ChartFive
//
//  Created by Pavel Bogart on 3/10/17.
//  Copyright © 2017 Pavel Bogart. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var tableView: UITableView!

  let bandCellId = "bandCellId"

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.title = "ChartFive"
    setUpTableView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let indexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: indexPath, animated: true)
    }
  }
  
  func setUpTableView() {
    tableView = UITableView()
    tableView.separatorStyle = .none
    tableView.estimatedRowHeight = 60.0

    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(BandTableViewCell.self, forCellReuseIdentifier: bandCellId)

    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      ])
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 1 {
      return BandsModel.songsArray.count
    }
    return BandsModel.bandsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: bandCellId,
                                             for: indexPath) as! BandTableViewCell
    cell.pictureImageView.image = nil
    cell.populateCell(for: indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var title = BandsModel.bandsArray[indexPath.item].title
    if indexPath.section == 1 {
      title = BandsModel.songsArray[indexPath.item].title
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
