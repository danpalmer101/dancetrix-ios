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

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form
            +++ Section("Payment Details")
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
            <<< PushRow<String>("for") { row in
                row.title = "Payment for"
                row.selectorTitle = "Payment for"
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
            <<< TextRow("other_for") { row in
                row.title = "Other"
                row.placeholder = "Enter other reason for payment"
                row.add(rule: RuleRequired())
                row.hidden = Condition.function(["for"], { form in
                        return ((form.rowBy(tag: "for") as? PushRow)?.value != "Other")
                    })
                }
            +++ Section("Anything else we should know?")
            <<< TextAreaRow("additional")
    }

}
