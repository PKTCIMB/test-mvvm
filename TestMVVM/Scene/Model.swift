//
//  Model.swift
//  TestMVVM
//
//  Created by Marut Sirinapho on 15/3/2565 BE.
//

import Foundation

// MARK: - Employee
struct Employees: Decodable {
    let status: String
    let data: [EmployeeData]
}

// MARK: - EmployeeData
struct EmployeeData: Decodable {
    let employeeName : String
    let id, employeeSalary, employeeAge : Int
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
