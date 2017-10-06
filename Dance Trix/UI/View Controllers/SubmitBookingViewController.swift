//
//  SubmitBookingViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class SubmitBookingViewController: SubmitFormViewController {

    var classDetails: Class!
    var allDates: [DateInterval]!
    var selectedDates: [DateInterval]!
    
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
            <<< TextRow("student_name") { row in
                    row.title = "Student name"
                    row.add(rule: RuleRequired())
                    row.placeholder = "Enter the dancer's full name"
                    if let studentName = Preferences.get(key: "student_name") {
                        row.value = studentName as? String
                    }
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
                    if let email = Preferences.get(key: "email") {
                        row.value = email as? String
                    }
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
        
        self.submitButton.setTitle("Submit booking", for: .normal)
        self.submitButton.addTarget(self, action: #selector(submitBooking), for: .touchUpInside)
        
        self.checkCompleteForm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.screenName != nil) {
            self.screenName = String(format: self.screenName!, self.classDetails.name)
        }
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        let studentNameRow = self.form.rowBy(tag: "student_name") as! TextRow
        let emailRow = self.form.rowBy(tag: "email") as! EmailRow
        
        self.submitButton.isEnabled =
            studentNameRow.value != nil && studentNameRow.isValid
            && emailRow.value != nil && emailRow.isValid
    }

    @objc private func submitBooking(sender: Any?) {
        let studentName = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        
        // Store student/email as preferences for next time
        Preferences.store(key: Preferences.KEY_STUDENT_NAME, value: studentName)
        Preferences.store(key: Preferences.KEY_EMAIL, value: email)
        
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submittingIndicator.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            ServiceLocator.bookingService.bookClass(
                classDetails: self.classDetails,
                dates: self.selectedDates,
                name: studentName,
                email: email,
                successHandler: {
                    Notification.show(
                        title: "Success",
                        subtitle: "Your booking for \(self.classDetails.name) was successful!",
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
