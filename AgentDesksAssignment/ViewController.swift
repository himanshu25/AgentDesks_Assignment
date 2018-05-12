//
//  ViewController.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ListItemCellDelegate {
    
    @IBOutlet weak var contentTable: UITableView!
    var facilities = [Facilities]()
    var vmArray = [ViewModel]()
    var cellArray = [ListItemTableViewCell]()
    var selectedId = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTable.dataSource = self
        contentTable.delegate = self
        contentTable.estimatedRowHeight = 200
        contentTable.tableFooterView = nil
        FacilitiesWorker.sharedInstance.getAllFacilities { [weak self] (error, facilities) in
            if let strongSelf = self, let facilities = facilities {
                strongSelf.facilities = facilities
                for f in facilities {
                    strongSelf.vmArray.append(f.vm)
                    for o in f.optionsArray {
                        strongSelf.vmArray.append(o.vm)
                    }
                }
                DispatchQueue.main.sync {
                    strongSelf.contentTable.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for f in facilities {
            count += 1
            for o in f.optionsArray {
                count += 1
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListItemTableViewCell
        if vmArray.count > 0 {
            cell.delegate = self
            cell.listItemView.vm = vmArray[indexPath.row]
            cell.setupUI()
            cellArray.append(cell)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func listItemCellSelected(_ listItemViewCell: ListItemTableViewCell) {
        if listItemViewCell.listItemView.vm?.id != selectedId {
            showErrorMessage()
        }
    }
    
    func showErrorMessage() {
        let popoverView = PopoverView()
            .with(messageTitle: "Error")
            .with(messageText: "Please select proper combination")
            .with(primaryButtonTitle: "OK")
        popoverView.show()
    }

}

