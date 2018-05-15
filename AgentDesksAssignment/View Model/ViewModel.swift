//
//  ViewModel.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 11/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation

class ViewModel {
    let option: Option?
    let facility: Facility?
    
    init(option: Option?, facility: Facility?) {
        self.option = option
        self.facility = facility
    }
}
