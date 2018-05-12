//
//  Option.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation

class Options {
    let id: String!
    let name: String!
    let icon: String!
    let vm: ViewModel!
    
    init(option: [String: AnyObject]) {
        self.id = option["id"] as! String
        self.name = option["name"] as! String
        self.icon = option["icon"] as! String
        self.vm = ViewModel(icon: self.icon, name: self.name, id: self.id)
    }
}
