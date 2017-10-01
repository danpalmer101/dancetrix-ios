//
//  SubmitBookingViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka

class SubmitBookingViewController: FormViewController {

    var classDetails: Class!
    var allDates: [DateInterval]!
    var selectedDates: [DateInterval]!
    
    @IBOutlet
    var submitButton: UIButton!
    @IBOutlet
    var submittingIndicator: UIActivityIndicatorView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM 'at' HH:mm"
        
        self.form
            +++ Section("Class")
            <<< TextRow() { row in
                row.title = "Name"
                row.value = self.classDetails.name
                row.disabled = Condition(booleanLiteral: true)
                }
           <<<  MultipleSelectorRow<String>("dates") { row in
                row.title = "Dates"
                row.options = self.allDates.map({ (date: DateInterval) -> String in dateFormatter.string(from: date.start) })
                row.value = Set(self.selectedDates.map({ (date: DateInterval) -> String in dateFormatter.string(from: date.start) }))
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.textColor = Theme.colorForeground
                        cell.tintColor = Theme.colorTint
                        cell.isUserInteractionEnabled = false
                    }
                })
            +++ Section("Your details")
            <<< TextRow("name") { row in
                row.title = "Name"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter your full name"
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
            <<< EmailRow("email") { row in
                row.title = "Email address"
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.placeholder = "Enter your email address"
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.bringSubview(toFront: self.submitButton)
        self.view.bringSubview(toFront: self.submittingIndicator)
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        let nameRow = self.form.rowBy(tag: "name") as! TextRow
        let emailRow = self.form.rowBy(tag: "email") as! EmailRow
        
        self.submitButton.isEnabled =
            nameRow.value != nil && nameRow.isValid
            && emailRow.value != nil && emailRow.isValid
    }
    
    @IBAction
    func submitBooking(sender: Any?) {
        let name = (self.form.rowBy(tag: "name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submittingIndicator.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            ServiceLocator.bookingService.bookClass(
                classDetails: self.classDetails,
                dates: self.selectedDates,
                name: name,
                email: email,
                successHandler: {
                    Notification.show(
                        title: "Success",
                        subtitle: String(format: "Your booking for %@ was successful!", self.classDetails.name),
                        type: NotificationType.success)
                    
                    DispatchQueue.main.async {
                        self.submitButton.isEnabled = true
                        self.submittingIndicator.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                        
                        self.performSegue(withIdentifier: "unwindToHomeViewController", sender: sender)
                    }
                },
                errorHandler: { (error: Error) in
                    log.error(["An unexpected error occurred submitting booking", error])
                    
                    Notification.show(
                        title: "Error",
                        subtitle: "An unexpected error occurred submitting your booking, please try again later.",
                        type: NotificationType.error)
                    
                    DispatchQueue.main.async {
                        self.submitButton.isEnabled = true
                        self.submittingIndicator.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                    }
                }
            )
        }
    }
    
}
