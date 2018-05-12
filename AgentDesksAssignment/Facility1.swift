//
//  Facility.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation

class Facilities {
    let id: String!
    let name: String!
    var optionsArray = [Options]()
    var vm: ViewModel!
    
    init(facility: [String: AnyObject]) {
        self.id = facility["facility_id"] as! String
        self.name = facility["name"] as! String
        self.vm = ViewModel(icon: "", name: self.name, id: self.id)
        if let options = facility["options"] as? [[String: AnyObject]] {
            for o in options {
                let option = Options(option: o)
                optionsArray.append(option)
            }
        }
    }
}
