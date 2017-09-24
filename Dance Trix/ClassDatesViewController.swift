//
//  ClassDatesViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 24/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class ClassDatesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var classDetails: Class!

    @IBOutlet
    var tableView: UITableView?
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classDetails.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = classDetails.dates[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassDate", for: indexPath)
        Theme.applyTableViewCell(tableCell: cell)
        
        cell.textLabel?.text = date.asText()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.tag = indexPath.row
        
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction
    func selectAll() {
        for section in 0..<(self.tableView?.numberOfSections ?? 1) {
            for row in 0..<(self.tableView?.numberOfRows(inSection: section) ?? 0) {
                self.tableView?.selectRow(
                    at: IndexPath(row: row, section: section),
                    animated: false,
                    scrollPosition: .none)
            }
        }
    }

}
