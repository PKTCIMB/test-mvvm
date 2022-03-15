//
//  ViewModel.swift
//  TestMVVM
//
//  Created by Marut Sirinapho on 15/3/2565 BE.
//

import Foundation

class EmployeesViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var empData : Employees? {
        didSet {
            self.bindEmployeeViewModelToController()
        }
    }
    
    var bindEmployeeViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetEmpData()
    }
    
    func callFuncToGetEmpData() {
        
        self.apiService.apiToGetEmployeeData { empData in
            self.empData = empData
        } fail: { errorMessage in
            print("Error : \(errorMessage ?? "UNKNOW")")
            self.bindEmployeeViewModelToController()
        }
    }
}
