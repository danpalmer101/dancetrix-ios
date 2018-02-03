//
//  RegisterAdultViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class RegisterAdultViewController: SubmitFormViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.setTitle("Next", for: .normal)
        
        self.form
            +++ Section("Your details")
            <<< TextRow("student_name") { row in
                row.title = "Name"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter your full name"
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
            +++ Section("Medical conditions/injuries")
            <<< TextAreaRow("medical")
            <<< LabelRow() { row in
                row.title = "Please note, we take no liability for injuries in class and all participation is at your own risk."
            }
            +++ Section("Previous dance experience")
            <<< TextAreaRow("experience")
            +++ Section("Your emergency contact")
            <<< TextRow("emergency_name") { row in
                row.title = "Name"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter emergency contact name"
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
            }
            <<< PhoneRow("emergency_phone") { row in
                row.title = "Phone number"
                row.add(rule: RuleRequired())
                row.placeholder = "Enter emergency contact phone number"
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                        cell.textField?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
            }
        
        self.checkCompleteForm()
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        let studentNameRow = self.form.rowBy(tag: "student_name") as! TextRow
        let dateRow = self.form.rowBy(tag: "date_of_birth") as! DateRow
        let emailRow = self.form.rowBy(tag: "email") as! EmailRow
        let phoneRow = self.form.rowBy(tag: "phone") as! PhoneRow
        let addressRow = self.form.rowBy(tag: "address") as! TextAreaRow
        let emergencyNameRow = self.form.rowBy(tag: "emergency_name") as! TextRow
        let emergencyPhoneRow = self.form.rowBy(tag: "emergency_phone") as! PhoneRow
        
        self.submitButton.isEnabled =
            studentNameRow.value != nil && studentNameRow.isValid
            && dateRow.value != nil && dateRow.isValid
            && emailRow.value != nil && emailRow.isValid
            && phoneRow.value != nil && phoneRow.isValid
            && addressRow.value != nil && addressRow.isValid
            && emergencyNameRow.value != nil && emergencyNameRow.isValid
            && emergencyPhoneRow.value != nil && emergencyPhoneRow.isValid
    }

    @objc private func next(sender: Any?) {
        let studentName = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        
        // Store student/email as preferences for next time
        Preferences.store(key: Preferences.KEY_STUDENT_NAME, value: studentName)
        Preferences.store(key: Preferences.KEY_EMAIL, value: email)
        
        // Go to signature
    }
    
}
