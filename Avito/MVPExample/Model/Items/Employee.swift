//
//  Employee.swift
//  MVPExample
//
//  Created by Виктор Поволоцкий on 18.08.2021.
//

import Foundation

class Employee: SomeEmployeesProtocol{
    var name: String?
    
    var phoneNumber: String?
    
    var skills: [String]
    
    init(name: String?, pNumber: String?, skills: [String]) {
        self.name = name
        self.phoneNumber = pNumber
        self.skills = skills
    }
}
