//
//  ClassDatesViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 24/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Firebase

class ClassDatesViewController: AnalyticsUIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var classDetails: Class!
    private var dates: [DateInterval]?

    @IBOutlet
    var descriptionView: MarkdownView!
    @IBOutlet
    var tableView: UITableView!
    @IBOutlet
    var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet
    var bookButton: UIButton!
    @IBOutlet
    var selectAllButton: UIButton!
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.allowsSelection = self.classDetails.allowIndividualBookings
        self.selectAllButton.isHidden = !self.tableView.allowsSelection
        self.descriptionView.textContainerInset = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0)
        
        
        self.loadDates()
        
        self.loadDescription()
        
        if (self.screenName != nil) {
            self.screenName = String(format: self.screenName!, self.classDetails.name)
        }
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
        
        // Hide the tick if selection is disabled
        cell.viewWithTag(98765)?.isHidden = !self.tableView.allowsSelection
        
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
            destination.allDates = self.dates
            
            if (self.classDetails.allowIndividualBookings) {
                // Selected dates
                destination.selectedDates = self.tableView.indexPathsForSelectedRows?.map({
                    (indexPath: IndexPath) -> DateInterval in return self.dates![indexPath.row]
                })
            } else {
                // All dates
                destination.selectedDates = self.dates
            }
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
        } else if (!self.classDetails.allowIndividualBookings) {
            // Block bookings only, enable with block booking text
            self.bookButton.isEnabled = true
            self.bookButton.setTitle("Book this block", for: .normal)
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
    
    private func loadDescription() {
        DispatchQueue.global().async {
            ServiceLocator.classService.getClassDescription(
                self.classDetails,
                successHandler: { (description: String) in
                    DispatchQueue.main.async {
                        self.descriptionView.setMarkdownText(description)
                    }
                },
                errorHandler: { (error: Error) in
                    log.error(["An unexpected error occurred loading class description", self.classDetails!, error])
                }
            )
        }
    }
    
    private func loadDates() {
        if (self.dates == nil) {
            self.loadingIndicator.startAnimating()
            self.updateBookButton()
        
            DispatchQueue.global().async {
                ServiceLocator.classService.getClassDates(
                    self.classDetails,
                    successHandler: { (dates: [DateInterval]) in
                        self.dates = dates
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.loadingIndicator.stopAnimating()
                            self.updateBookButton()
                        }
                    },
                    errorHandler: { (error: Error) in
                        switch error {
                        case ClassesError.noClassDates:
                            log.warning(["No class dates found", self.classDetails!])
                            
                            Notification.show(
                                title: "Sorry!",
                                subtitle: "There aren't any dates available for \(self.classDetails.name) at the moment.",
                                type: NotificationType.warning)
                            
                            break
                        default:
                            log.error(["An unexpected error occurred loading class dates", self.classDetails!])
                            
                            Notification.show(
                                title: "Error",
                                subtitle: "An unexpected error occurred loading dates for \(self.classDetails.name), please try again later.",
                                type: NotificationType.error)
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.loadingIndicator.stopAnimating()
                            self.updateBookButton()
                        }
                    }
                )
            }
        } else {
            self.updateBookButton()
        }
    }

}
