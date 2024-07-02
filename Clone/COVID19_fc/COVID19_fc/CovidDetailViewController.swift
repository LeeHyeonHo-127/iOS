//
//  CovidDetailViewController.swift
//  COVID19
//
//  Created by Gunter on 2021/09/19.
//

import UIKit

class CovidDetailViewController: UITableViewController {
    @IBOutlet var newCaseCell: UITableViewCell!
    var covidOverview: CovidOverview?
    @IBOutlet var totalCaseCell: UITableViewCell!
    @IBOutlet var recoveredCell: UITableViewCell!
    @IBOutlet var deathCell: UITableViewCell!
    @IBOutlet var percentageCell: UITableViewCell!
    @IBOutlet var overseasInflowCell: UITableViewCell!
    @IBOutlet var regionalOutbreakCell: UITableViewCell!
    
  override func viewDidLoad() {
    super.viewDidLoad()
      print(covidOverview)

    //self.configureView()
  }

  func configureView() {
    guard let covidOverview = self.covidOverview else { return }
    self.title = covidOverview.countryName
      self.newCaseCell.UIListContentConfiguration
    self.newCaseCell.detailTextLabel?.text = "\(covidOverview.newCase)명"
    self.totalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase)명"
    self.recoveredCell.detailTextLabel?.text = "\(covidOverview.recovered)명"
    self.deathCell.detailTextLabel?.text = "\(covidOverview.death)명"
    self.percentageCell.detailTextLabel?.text = "\(covidOverview.percentage)%"
    self.overseasInflowCell.detailTextLabel?.text = "\(covidOverview.newFcase)명"
    self.regionalOutbreakCell.detailTextLabel?.text = "\(covidOverview.newCcase)명"
  }
}
