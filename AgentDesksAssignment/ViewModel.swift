//
//  ViewModel.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation

class ViewModel {
    let icon: String!
    let name: String!
    let id: String!
    
    init(icon: String?, name: String, id: String) {
        self.icon = icon
        self.name = name
        self.id = id
    }
}
