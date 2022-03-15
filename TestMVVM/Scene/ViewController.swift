//
//  ViewController.swift
//  TestMVVM
//
//  Created by Marut Sirinapho on 15/3/2565 BE.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var employeeTableView: UITableView!
    
    private var employeeViewModel : EmployeesViewModel!
    
    private var dataSource : EmployeeTableViewDataSource<EmployeeTableViewCell,EmployeeData>!
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        callToViewModelForUIUpdate()
    }
    
    func setUpUI() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        employeeTableView.addSubview(refreshControl)
    }
    
    func callToViewModelForUIUpdate(){
        self.employeeViewModel =  EmployeesViewModel()
        self.employeeViewModel.bindEmployeeViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        guard let data = self.employeeViewModel.empData?.data else {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
            return
        }
        
        self.dataSource = EmployeeTableViewDataSource(cellIdentifier: "EmployeeTableViewCell", items: data, configureCell: { (cell, evm) in
            cell.employeeIdLabel.text = String(evm.id)
            cell.employeeNameLabel.text = evm.employeeName
        })
        
        DispatchQueue.main.async {
            self.employeeTableView.dataSource = self.dataSource
            self.employeeTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // Action
    @objc func refresh(_ sender: AnyObject) {
        callToViewModelForUIUpdate()
    }
}
