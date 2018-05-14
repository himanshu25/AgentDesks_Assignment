//
//  ViewController.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ListItemCellDelegate {
    
    @IBOutlet weak var contentTable: UITableView!
    var facilities = [Facility]()
    var cellArray = [ListItemTableViewCell]()
    var vmArray = [ViewModel]()
    var selectedId = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        FacilitiesWorker.sharedInstance.getAllFacilities { [weak self] (error, facilities) in
            if let strongSelf = self, let facilities = facilities {
                strongSelf.facilities = facilities
                for f in facilities {
                    let vm = ViewModel(icon: nil, name: f.name!, id: f.facilityId!)
                    strongSelf.vmArray.append(vm)
                    for o in f.options! {
                        let opt = o as! Option
                        
                        let vm = ViewModel(icon: opt.icon!, name: opt.name!, id: opt.id!)
                        strongSelf.vmArray.append(vm)
                    }
                }
                DispatchQueue.main.sync {
                    self?.contentTable.reloadData()
                }
        }
    }
    }
    
    private func setupTableView(){
        contentTable.dataSource = self
        contentTable.delegate = self
        contentTable.estimatedRowHeight = 200
        contentTable.tableFooterView = nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return vmArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemTableViewCell
        cell.listItemView.titleLabel.text = vmArray[indexPath.row].name
        if let icon = vmArray[indexPath.row].icon {
          cell.listItemView.leftIconImage = UIImage(named: icon)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func listItemCellSelected(_ listItemViewCell: ListItemTableViewCell) {
       
    }
    
   private func showErrorMessage() {
        let popoverView = PopoverView()
            .with(messageTitle: "Error")
            .with(messageText: "Please select proper combination")
            .with(primaryButtonTitle: "OK")
        popoverView.show()
    }

}

