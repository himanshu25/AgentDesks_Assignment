//
//  ViewController.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ListItemViewDelegate {
    
    @IBOutlet weak var contentTable: UITableView!
    var facilities = [Facility]()
    private var cellArray = [ListItemTableViewCell]()
    private var vmArray = [ViewModel]()
    private var firstSelectedOption: Option?
    private var secondSelectedOption: Option?
    private var firstSelectedfacility: Facility?
    private var secondSelectedFacility: Facility?
    private var excludedOption: NSSet?
    private var currentListItemView = ListItemView()
    
    lazy var fetchedhResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Facility.self))
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.sharedInstance.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        FacilityWorker.sharedInstance.getAllFacilities { [weak self] (error, facilities) in
            if let strongSelf = self, let facilities = facilities {
                for f in facilities {
                    let vm = ViewModel(option: nil, facility: f)
                    strongSelf.vmArray.append(vm)
                    for o in f.options! {
                        let opt = o as! Option
                        let vm = ViewModel(option: opt, facility: f)
                        strongSelf.vmArray.append(vm)
                    }
                }
                DispatchQueue.main.sync {
                    self?.contentTable.reloadData()
                }
            }
            else {
                self?.showErrorMessage()
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
        cell.listItemView.delegate = self
        if vmArray.count > 0 {
            cell.listItemView.vm = vmArray[indexPath.row]
        }
        cell.listItemView.titleLabel.text = (vmArray[indexPath.row].option?.name != nil) ? vmArray[indexPath.row].option?.name: vmArray[indexPath.row].facility?.name
        if let icon = vmArray[indexPath.row].option?.icon {
          cell.listItemView.leftIconImage = UIImage(named: icon)
         cell.listItemView.rightIconImageView.image = UIImage(named: "Empty Check")
        }
        else {
            cell.listItemView.titleLabel.textColor = UIColor.black
            cell.isUserInteractionEnabled = false
        }
        cellArray.append(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // To Do:  Divide it in separate responsbility
    func listItemSelected(_ listItemView: ListItemView) {
        if firstSelectedfacility == nil {
            firstSelectedfacility = listItemView.vm.facility
            firstSelectedOption = listItemView.vm.option
            listItemView.rightIconImageView.image = UIImage(named: "Radio Filled")
        }
        else {
            if listItemView.vm.facility ==  firstSelectedfacility || listItemView.vm.facility ==  secondSelectedFacility {
                for cell in cellArray {
                    if let option = cell.listItemView.vm.option {
                        cell.listItemView.rightIconImageView.image = UIImage(named: "Empty Check")
                    }
                }
                listItemView.rightIconImageView.image = UIImage(named: "Radio Filled")
                if listItemView.vm.facility ==  firstSelectedfacility {
                    firstSelectedOption = listItemView.vm.option
                    firstSelectedfacility = listItemView.vm.facility
                    secondSelectedFacility = nil
                    secondSelectedOption = nil
                }
                else {
                    firstSelectedOption = secondSelectedOption
                    firstSelectedfacility = secondSelectedFacility
                    secondSelectedFacility = nil
                    secondSelectedOption = nil
                }
            }
            else {
                secondSelectedFacility = listItemView.vm.facility
                secondSelectedOption = listItemView.vm.option
                var isFirstOption = false
                var isSecondOption = false
                for ex in (listItemView.vm.option?.exclusions)! {
                    if (ex as! Option).id == firstSelectedOption?.id {
                        isFirstOption = true
                    }
                }
                for ex in (listItemView.vm.option?.exclusions)! {
                    if (ex as! Option).id == secondSelectedOption?.id {
                        isSecondOption = true
                    }
                }
                if isFirstOption && isSecondOption {
                    showErrorMessage()
                }
                else {
                    listItemView.rightIconImageView.image = UIImage(named: "Radio Filled")
                }
            }
        }
        
    }
    
   private func showErrorMessage() {
        let popoverView = PopoverView()
            .with(messageTitle: "Error")
            .with(messageText: "Please select proper combination")
            .with(primaryButtonTitle: "OK")
        popoverView.show()
    }

}

