//
//  HomeViewController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 29/6/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//
import UIKit
import FBSDKLoginKit
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var cell: UITableViewCell!
    @IBAction func logout(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    
    let climbDao = ClimbDao()
    var climbList = [Climb]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        let nib = UINib(nibName: "ClimbCell", bundle: nil)
        table.register(nib, forCellReuseIdentifier: "climbCell")
        
        activityIndicatorView.startAnimating()
        
        // Load climbs
        climbDao.readAll(completionHandler: { climb in
            self.climbList = climb
            self.table.reloadData()
            self.activityIndicatorView.stopAnimating()
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Must implement these.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return climbList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell") as! ClimbCell
        let name = climbList[indexPath.row].name

        // Split name up for initials
        let nameArray = name.characters.split(separator: " ")
        var initials = ""
        for i in nameArray {
             initials += String(i.prefix(1))
        }
        
        cell.initialLabel.text = initials.uppercased()
        cell.nameLabel.text = name
        cell.difRatingLabel.text = "Difficulty: \(climbList[indexPath.row].rating)"
        cell.wallLabel.text = climbList[indexPath.row].wall
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showClimbSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showClimbSegue" {
            let indexPath = sender as! IndexPath
            let row = indexPath.row
            let vc = segue.destination as! ClimbDetailViewController
            vc.climb = climbList[row]
        }
    }
}
