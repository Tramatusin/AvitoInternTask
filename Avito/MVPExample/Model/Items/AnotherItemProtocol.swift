//
//  AnotherImerProtocol.swift
//  MVVMExample
//
//  Created by Виктор Поволоцкий on 07.08.2021.
//

import Foundation

protocol SomeCompanyProtocol {
    var companyName: String {get}
    var employees: [SomeEmployeesProtocol?] {get}
}

protocol SomeEmployeesProtocol{
    var name: String? { get }
    var phoneNumber: String? { get }
    var skills: [String] {get}
}
