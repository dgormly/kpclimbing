//
//  HomeViewController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 29/6/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var cell: UITableViewCell!
    
    let climbDao = ClimbDao()
    var climbList = [Climb]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        let nib = UINib(nibName: "ClimbCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "climbCell")
        
        activityIndicatorView.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Load climbs
        climbDao.readAll(completionHandler: { climb in
            self.climbList = climb
            self.table.reloadData()
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    // MARK: Must implement these.
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return climbList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell") as! ClimbCell
        let name = climbList[indexPath.row].name
        let index = name.index(name.startIndex, offsetBy: 1)
        cell.initialLabel.text = name.substring(to: index).uppercased()
        cell.nameLabel.text = name
        cell.difRatingLabel.text = "Difficulty: " + String(climbList[indexPath.row].rating)
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showClimbSegue", sender: nil)
    }
}
