//
//  RegisterChildViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class RegisterChildViewController: SubmitFormViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.setTitle("Next", for: .normal)
        
        self.form
            +++ Section("Student details")
            <<< TextRow("student_name") { row in
                row.title = "Name"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter student's full name"
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
            <<< DateRow("date_of_birth") { row in
                row.title = "Date of birth"
                row.add(rule: RuleRequired())
                row.maximumDate = Date()
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
            }
            <<< DateRow("date_joined") { row in
                row.title = "Date joined Dance Trix"
                row.add(rule: RuleRequired())
                row.maximumDate = Date()
                row.value = Date()
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
            }
            +++ Section("Medical conditions/injuries")
            <<< TextAreaRow("medical")
            <<< LabelRow() { row in
                row.title = "Please note, we take no liability for injuries in class and all participation is at your own risk."
            }
            +++ Section("Previous dance experience")
            <<< TextAreaRow("experience")
            +++ Section("Parent / guardian details")
            <<< TextRow("name") { row in
                row.title = "Name"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter your full name"
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
            <<< PhoneRow("phone") { row in
                row.title = "Phone number"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter your phone number"
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
            +++ Section("Address")
            <<< TextAreaRow("address") { row in
                row.add(rule: RuleRequired())
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textView?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
            }
            +++ Section("How did you hear about us?")
            <<< TextAreaRow("hear_about") { row in
                row.add(rule: RuleRequired())
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textView?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
            }
            +++ Section("Contact")
            <<< PushRow<String>("contact") { row in
                row.title = "Preferred contact method"
                row.selectorTitle = "Select your preference"
                row.options = [
                    "Email",
                    "Text",
                    "Printed information",
                    "Text to highlight an email has been sent"
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
            <<< LabelRow() { row in
                row.title = "Please note, we will endeavour to make this our primary method of communication but from time to time will also use other methods."
            }
        
        self.checkCompleteForm()
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        // TODO check form values
        
        self.submitButton.isEnabled = false
    }

    @objc private func next(sender: Any?) {
        // Go to signature
    }
    
}
