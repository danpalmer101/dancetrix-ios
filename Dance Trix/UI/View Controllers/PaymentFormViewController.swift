//
//  PaymentFormViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 30/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class PaymentFormViewController: SubmitFormViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form
            +++ Section("Your details")
            <<< TextRow("name") { row in
                    row.title = "Your name"
                    row.placeholder = "Enter your name"
                    row.add(rule: RuleRequired())
                    if let name = Preferences.get(key: "name") {
                        row.value = name as? String
                    }
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
            <<< TextRow("student_name") { row in
                    row.title = "Student's name"
                    row.placeholder = "Enter the student's name"
                    row.add(rule: RuleRequired())
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
            +++ Section("Your payment")
            <<< DateRow("date") { row in
                    row.title = "Date"
                    row.value = Date()
                    row.maximumDate = Date()
                    row.add(rule: RuleRequired())
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
            <<< DecimalRow("amount") { row in
                    row.title = "Amount"
                    row.placeholder = "Enter payment amount"
                    row.add(rule: RuleRequired())
                    row.add(rule: RuleGreaterThan(min: 0))
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
            <<< PushRow<String>("method") { row in
                    row.title = "Method"
                    row.selectorTitle = "Select a method"
                    row.options = [
                        "Bank transfer",
                        "PayPal",
                        "Credit/Debit card",
                        "Cash"
                    ]
                    row.add(rule: RuleRequired())
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.textColor = Theme.colorForeground
                        cell.tintColor = Theme.colorTint
                    }
                })
            <<< PushRow<String>("reason") { row in
                    row.title = "Reason"
                    row.selectorTitle = "Select a reason"
                    row.options = [
                        "Children's lesson fees (termly)",
                        "Children's lesson fee (pay as you go)",
                        "Adult's lesson fees (quarterly or monthly)",
                        "Uniform / dancewear",
                        "Show fee",
                        "Exam fee",
                        "Private lesson",
                        "Ballet Burn loyalty card",
                        "Other"
                    ]
                    row.add(rule: RuleRequired())
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.textColor = Theme.colorForeground
                        cell.tintColor = Theme.colorTint
                    }
                })
            <<< TextRow("other_reason") { row in
                    row.title = "Other"
                    row.placeholder = "Enter other reason for payment"
                    row.add(rule: RuleRequired())
                    row.hidden = Condition.function(["reason"], { form in
                        return ((form.rowBy(tag: "reason") as? PushRow<String>)?.value != "Other")
                    })
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }
            +++ Section("Anything else we should know?")
            <<< TextAreaRow("additional")
                .cellUpdate { cell, row in
                    self.checkCompleteForm()
                }
        
        self.submitButton.setTitle("Submit payment details", for: .normal)
        self.submitButton.addTarget(self, action: #selector(submitPaymentNotification), for: .touchUpInside)
        
        self.checkCompleteForm()
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        guard let date = (self.form.rowBy(tag: "date") as? DateRow),
              let amount = (self.form.rowBy(tag: "amount") as? DecimalRow),
              let name = (self.form.rowBy(tag: "name") as? TextRow),
              let studentName = (self.form.rowBy(tag: "student_name") as? TextRow),
              let email = (self.form.rowBy(tag: "email") as? EmailRow),
              let method = (self.form.rowBy(tag: "method") as? PushRow<String>),
              let reason = (self.form.rowBy(tag: "reason") as? PushRow<String>),
              let additional = (self.form.rowBy(tag: "additional") as? TextAreaRow)
        else {
            self.submitButton.isEnabled = false
            return
        }
        
        var otherReason: TextRow?
        if (reason.value == "Other") {
            otherReason = (self.form.rowBy(tag: "other_reason") as? TextRow)
        }
        
        self.submitButton.isEnabled = date.value != nil && date.isValid
            && amount.value != nil && amount.isValid
            && name.value != nil && name.isValid
            && studentName.value != nil && studentName.isValid
            && email.value != nil && email.isValid
            && method.value != nil && method.isValid
            && reason.value != nil && reason.isValid
            && (reason.value != "Other" || (otherReason?.value != nil && otherReason?.isValid ?? false))
            && additional.isValid
    }
    
    @objc private func submitPaymentNotification(sender: Any?) {
        let date = (self.form.rowBy(tag: "date") as! DateRow).value!
        let amount = (self.form.rowBy(tag: "amount") as! DecimalRow).value!
        let name = (self.form.rowBy(tag: "name") as! TextRow).value!
        let studentName = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        let method = (self.form.rowBy(tag: "method") as! PushRow<String>).value!
        var reason = (self.form.rowBy(tag: "reason") as! PushRow<String>).value!
        if (reason == "Other") {
            reason = (self.form.rowBy(tag: "other_reason") as! TextRow).value!
        }
        let additional = (self.form.rowBy(tag: "additional") as! TextAreaRow).value
        
        // Store name/student/email as preferences for next time
        Preferences.store(key: Preferences.KEY_NAME, value: name)
        Preferences.store(key: Preferences.KEY_STUDENT_NAME, value: studentName)
        Preferences.store(key: Preferences.KEY_EMAIL, value: email)
        
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submitButton.activityIndicator?.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            ServiceLocator.paymentService.notify(
                date: date,
                amount: amount,
                name: name,
                studentName: studentName,
                email: email,
                method: method,
                reason: reason,
                additionalInfo: additional,
                successHandler: {
                    Notification.show(
                        title: "Success",
                        subtitle: "Thanks for letting us know!",
                        type: NotificationType.success)
                    
                    DispatchQueue.main.async {
                        self.submitButton.isEnabled = true
                        self.submitButton.activityIndicator?.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                        
                        self.performSegue(withIdentifier: "unwindToHomeViewController", sender: sender)
                    }
                },
                errorHandler: { (error: Error) in
                    log.error(["An unexpected error occurred notifing payment", error])
                    
                    Notification.show(
                        title: "Error",
                        subtitle: "An unexpected error occurred submitting your payment information, please try again later.",
                        type: NotificationType.error)
                    
                    DispatchQueue.main.async {
                        self.submitButton.isEnabled = true
                        self.submitButton.activityIndicator?.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                    }
            })
        }
    }

}
