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
    var dates: [DateInterval]?

    @IBOutlet
    var tableView: UITableView?
    @IBOutlet
    var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet
    var bookButton: UIButton?
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadDates()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = self.dates?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassDate", for: indexPath)
        Theme.applyTableViewCell(tableCell: cell)
        
        cell.textLabel?.text = date?.asText()
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
        if (self.loadingIndicator?.isAnimating ?? false) {
            // Loading, disable without text
            self.bookButton?.isEnabled = false
            self.bookButton?.setTitle("", for: .normal)
        } else if let count = tableView?.indexPathsForSelectedRows?.count {
            // Loaded with selected dates, enable with text showing number of dates
            self.bookButton?.isEnabled = true
            if count == 1 {
                self.bookButton?.setTitle("Book \(count) date", for: .normal)
            } else {
                self.bookButton?.setTitle("Book \(count) dates", for: .normal)
            }
        } else {
            // Loaded without selected dates, disable with text
            self.bookButton?.isEnabled = false
            self.bookButton?.setTitle("Select dates", for: .normal)
        }
    }
    
    private func loadDates() {
        self.loadingIndicator?.startAnimating()
        self.updateBookButton()
        
        DispatchQueue.global().async {
            sleep(5)
            
            // Today at 8pm
            var baseDateComponents = Calendar.current.dateComponents([.calendar, .year, .month, .day], from: Date())
            baseDateComponents.hour = 20
            let baseDate = baseDateComponents.date
            
            let minute: TimeInterval = 60.0
            let hour: TimeInterval = 60.0 * minute
            let day: TimeInterval = 24 * hour
            
            // Create dates every 7 days
            let interval: TimeInterval = 7 * day
            
            self.dates = [
                DateInterval(start: baseDate!.addingTimeInterval(interval), duration: hour),
                DateInterval(start: baseDate!.addingTimeInterval(2*interval), duration: hour),
                DateInterval(start: baseDate!.addingTimeInterval(3*interval), duration: hour),
                DateInterval(start: baseDate!.addingTimeInterval(4*interval), duration: hour),
                DateInterval(start: baseDate!.addingTimeInterval(5*interval), duration: hour)
            ]
            
            DispatchQueue.main.async(execute: {
                self.tableView?.reloadData()
                self.loadingIndicator?.stopAnimating()
                self.updateBookButton()
            })
        }
    }

}
