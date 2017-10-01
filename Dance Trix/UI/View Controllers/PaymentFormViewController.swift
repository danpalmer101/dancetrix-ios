//
//  PaymentFormViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 30/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka

class PaymentFormViewController: FormViewController {

    @IBOutlet
    var submitButton: UIButton!
    @IBOutlet
    var submittingIndicator: UIActivityIndicatorView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form
            +++ Section("Your details")
            <<< TextRow("name") { row in
                row.title = "Your name"
                row.placeholder = "Enter your name"
                row.add(rule: RuleRequired())
                }
            <<< TextRow("student_name") { row in
                row.title = "Student name"
                row.placeholder = "Enter the student's name"
                row.add(rule: RuleRequired())
                }
            <<< EmailRow("email") { row in
                row.title = "Email address"
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.placeholder = "Enter your email address"
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textField?.textColor = Theme.colorError
                    }
                }
            +++ Section("Your payment")
            <<< DateRow("date") { row in
                row.title = "Payment date"
                row.value = Date()
                row.maximumDate = Date()
                row.add(rule: RuleRequired())
                }
            <<< DecimalRow("amount") { row in
                row.title = "Payment amount"
                row.placeholder = "Enter payment amount"
                row.add(rule: RuleRequired())
                row.add(rule: RuleGreaterThan(min: 0))
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textField?.textColor = Theme.colorError
                    }
                }
            <<< PushRow<String>("method") { row in
                row.title = "Payment method"
                row.selectorTitle = "Select a method"
                row.options = [
                    "Bank transfer",
                    "PayPal",
                    "Credit/Debit card",
                    "Cash"
                ]
                row.add(rule: RuleRequired())
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.textColor = Theme.colorForeground
                        cell.tintColor = Theme.colorTint
                    }
                })
            <<< PushRow<String>("reason") { row in
                row.title = "Payment reason"
                row.selectorTitle = "Select a reason"
                row.options = [
                    "Lesson fees (termly [children] / quarterly or monthly [adults])",
                    "Pay as you go lesson fee (children)",
                    "Uniform / dancewear",
                    "Show fee",
                    "Exam fee",
                    "Private lesson",
                    "Ballet Burn loyalty card",
                    "Other"
                ]
                row.add(rule: RuleRequired())
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
                }
            +++ Section("Anything else we should know?")
            <<< TextAreaRow("additional")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.bringSubview(toFront: self.submitButton)
        self.view.bringSubview(toFront: self.submittingIndicator)
    }
    
    // MARK: - Actions
    
    @IBAction
    func submitBooking(sender: Any?) {
        let date = (self.form.rowBy(tag: "date") as! DateRow).value!
        let amount = (self.form.rowBy(tag: "amount") as! DecimalRow).value!
        let name = (self.form.rowBy(tag: "name") as! TextRow).value!
        let studentName = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let method = (self.form.rowBy(tag: "method") as! PushRow<String>).value!
        var reason = (self.form.rowBy(tag: "reason") as! PushRow<String>).value!
        if (reason == "Other") {
            reason = (self.form.rowBy(tag: "other_reason") as! TextRow).value!
        }
        let additional = (self.form.rowBy(tag: "additional") as! TextAreaRow).value
        
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submittingIndicator.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            ServiceLocator.paymentService.notify(
                date: date,
                amount: amount,
                name: name,
                studentName: studentName,
                method: method,
                reason: reason,
                otherDetails: additional,
                successHandler: {
                    Notification.show(
                        title: "Success",
                        subtitle: "Thanks for letting us know!",
                        type: NotificationType.success)
                    
                    DispatchQueue.main.async {
                        self.submitButton.isEnabled = true
                        self.submittingIndicator.stopAnimating()
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
                        self.submittingIndicator.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                    }
            }
            )
        }
    }

}
