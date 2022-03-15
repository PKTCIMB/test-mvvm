//
//  APIService.swift
//  TestMVVM
//
//  Created by Marut Sirinapho on 15/3/2565 BE.
//

import Foundation
import UIKit

class APIService :  NSObject {
    
    private let sourcesURL = URL(string: "http://dummy.restapiexample.com/api/v1/employees")!

    func apiToGetEmployeeData(completion : @escaping (Employees) -> (), fail: @escaping (_ message: String?) -> ()){
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let empData = try? jsonDecoder.decode(Employees.self, from: data) {
                    completion(empData)
                } else {
                    fail("Cannot decode JSON")
                }
            }
        }.resume()
    }
    
//    func apiToGetEmployeeData(completion : @escaping (Employees) -> ()){
//        let url = Bundle.main.url(forResource: "employees", withExtension: "json")!
//        do {
//            let jsonData = try Data(contentsOf: url)
//            let decoder = JSONDecoder()
//            let employeeData = try decoder.decode(Employees.self, from: jsonData)
//            completion(employeeData)
//        } catch { print(error) }
//    }
}
