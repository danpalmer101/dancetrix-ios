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
    
    let registration = RegistrationChild()
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.setTitle("Next", for: .normal)
        self.submitButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        
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
        let nameRow = self.form.rowBy(tag: "name") as! TextRow
        let studentNameRow = self.form.rowBy(tag: "student_name") as! TextRow
        let emailRow = self.form.rowBy(tag: "email") as! EmailRow
        let dateJoinedRow = self.form.rowBy(tag: "date_joined") as! DateRow
        let dateOfBirthRow = self.form.rowBy(tag: "date_of_birth") as! DateRow
        let phoneRow = self.form.rowBy(tag: "phone") as! PhoneRow
        let addressRow = self.form.rowBy(tag: "address") as! TextAreaRow
        let contactRow = self.form.rowBy(tag: "contact") as! PushRow<String>
        
        self.submitButton.isEnabled =
            nameRow.value != nil && nameRow.isValid
            && studentNameRow.value != nil && studentNameRow.isValid
            && emailRow.value != nil && emailRow.isValid
            && dateJoinedRow.value != nil && dateJoinedRow.isValid
            && dateOfBirthRow.value != nil && dateOfBirthRow.isValid
            && phoneRow.value != nil && phoneRow.isValid
            && addressRow.value != nil && addressRow.isValid
            && contactRow.value != nil && contactRow.isValid
    }

    @objc private func nextStep(sender: Any?) {
        let name = (self.form.rowBy(tag: "name") as! TextRow).value!
        let studentName = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        
        // Store name/student/email as preferences for next time
        Preferences.store(key: Preferences.KEY_NAME, value: name)
        Preferences.store(key: Preferences.KEY_STUDENT_NAME, value: studentName)
        Preferences.store(key: Preferences.KEY_EMAIL, value: email)
        
        registration.name = name
        registration.studentName = studentName
        registration.email = email
        registration.dateJoined = (self.form.rowBy(tag: "date_joined") as! DateRow).value!
        registration.dateOfBirth = (self.form.rowBy(tag: "date_of_birth") as! DateRow).value!
        registration.phone = (self.form.rowBy(tag: "phone") as! PhoneRow).value!
        registration.address = (self.form.rowBy(tag: "address") as! TextAreaRow).value!
        registration.medical = (self.form.rowBy(tag: "medical") as! TextAreaRow).value
        registration.experience = (self.form.rowBy(tag: "experience") as! TextAreaRow).value
        registration.hearAbout = (self.form.rowBy(tag: "hear_about") as! TextAreaRow).value
        registration.contact = (self.form.rowBy(tag: "contact") as! PushRow<String>).value!
        
        // Go to photo consent
        self.performSegue(withIdentifier: "PhotoConsent", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "PhotoConsent") {
            let photoConsentViewController = (segue.destination as! PhotoConsentViewController)
            photoConsentViewController.registration = registration
        }
    }
    
}
