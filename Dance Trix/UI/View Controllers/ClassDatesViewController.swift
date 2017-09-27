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
    var tableView: UITableView!
    @IBOutlet
    var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet
    var bookButton: UIButton!
    
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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "Book") {
            let destination: SubmitBookingViewController = segue.destination as! SubmitBookingViewController
            destination.classDetails = self.classDetails
            destination.dates = self.tableView.indexPathsForSelectedRows?.map({
                (indexPath: IndexPath) -> DateInterval in return self.dates![indexPath.row]
            })
        }
    }
    
    // MARK: - Actions
    
    @IBAction
    func selectAll() {
        for section in 0..<(self.tableView.numberOfSections) {
            for row in 0..<(self.tableView.numberOfRows(inSection: section)) {
                self.tableView.selectRow(
                    at: IndexPath(row: row, section: section),
                    animated: false,
                    scrollPosition: .none)
            }
        }
        self.updateBookButton()
    }
    
    private func updateBookButton() {
        if (self.loadingIndicator.isAnimating) {
            // Loading, disable without text
            self.bookButton.isEnabled = false
            self.bookButton.setTitle("", for: .normal)
        } else if let count = tableView.indexPathsForSelectedRows?.count {
            // Loaded with selected dates, enable with text showing number of dates
            self.bookButton.isEnabled = true
            if count == 1 {
                self.bookButton.setTitle("Book \(count) date", for: .normal)
            } else {
                self.bookButton.setTitle("Book \(count) dates", for: .normal)
            }
        } else {
            // Loaded without selected dates, disable with text
            self.bookButton.isEnabled = false
            self.bookButton.setTitle("Select dates", for: .normal)
        }
    }
    
    private func loadDates() {
        if (self.dates == nil) {
            self.loadingIndicator.startAnimating()
            self.updateBookButton()
        
            DispatchQueue.global().async {
                do {
                    try self.dates = ServiceLocator.classService.getClassDates(self.classDetails)
                } catch ClassesError.noClassDates(_) {
                    // TODO
                } catch ClassesError.errorRetrivingClassDates(_) {
                    // TODO
                } catch {
                    // TODO
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.updateBookButton()
                }
            }
        } else {
            self.updateBookButton()
        }
    }

}
