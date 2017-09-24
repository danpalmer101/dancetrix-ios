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
    
    @IBOutlet
    var bookButton: UIButton?
    
    // MARK: - View lifecylce
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateBookButton()
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateBookButton()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.updateBookButton()
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
        self.updateBookButton()
    }
    
    private func updateBookButton() {
        if let count = tableView?.indexPathsForSelectedRows?.count {
            self.bookButton?.isEnabled = true
            if count == 1 {
                self.bookButton?.setTitle("Book \(count) date", for: .normal)
            } else {
                self.bookButton?.setTitle("Book \(count) dates", for: .normal)
            }
        } else {
            self.bookButton?.isEnabled = false
            self.bookButton?.setTitle("Select dates", for: .normal)
        }
    }

}
