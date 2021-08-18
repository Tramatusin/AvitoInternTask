//
//  Company.swift
//  MVPExample
//
//  Created by Виктор Поволоцкий on 18.08.2021.
//

import Foundation

class Company: SomeCompanyProtocol{
    var companyName: String
    
    var employees: [SomeEmployeesProtocol?]
    
    init(name: String,employees: [SomeEmployeesProtocol?]) {
        self.companyName = name
        self.employees = employees
    }
}
