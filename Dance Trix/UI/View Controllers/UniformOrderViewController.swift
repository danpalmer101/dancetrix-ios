//
//  UniformOrderViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka

class UniformOrderViewController: FormViewController {

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
            +++ Section("Your order")
            +++ Section("Your payment")
            <<< SwitchRow("payment_made") { row in
                row.title = "Payment made"
                }
            <<< PushRow<String>("payment_method") { row in
                row.title = "Payment method"
                row.selectorTitle = "Select a method"
                row.options = [
                    "Bank transfer",
                    "PayPal",
                    "Credit/Debit card",
                    "Cheque"
                ]
                row.add(rule: RuleRequired())
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.textColor = Theme.colorForeground
                        cell.tintColor = Theme.colorTint
                    }
                })
            +++ Section("Anything else we should know?")
            <<< TextAreaRow("additional")
        
    }

}
