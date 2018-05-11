//
//  ViewController.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var contentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.dataSource = self
        contentTable.delegate = self
        FacilitiesWorker.sharedInstance.getAllFacilities { (error, dsd) in
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemTableViewCell
        return cell
    }

}

