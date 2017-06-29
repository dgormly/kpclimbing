//
//  HomeViewController.swift
//  KangarooPointClimbing
//
//  Created by Daniel Gormly on 29/6/17.
//  Copyright © 2017 Daniel Gormly. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var cell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
    }
    
    // MARK: Must implement these.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "climbCell") as! ClimbCell
        return cell
    }
    
    
    
    
}
