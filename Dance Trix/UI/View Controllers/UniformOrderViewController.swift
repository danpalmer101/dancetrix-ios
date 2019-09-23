//
//  UniformOrderViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class UniformOrderViewController: SubmitFormViewController {

    var orderItems : [UniformGroup]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.submitButton.addTarget(self, action: #selector(self.submitOrder), for: .touchUpInside)
        
        self.submitButton.setTitle("", for: .normal)
        self.submitButton.isEnabled = false
        self.submitButton.activityIndicator?.startAnimating()
        
        ServiceLocator.uniformService.getUniformOrderItems(
            successHandler: { (orderItems) in
                self.orderItems = orderItems
                
                DispatchQueue.main.async {
                    self.buildForm()
                    
                    self.submitButton.setTitle("Submit order", for: .normal)
                    self.submitButton.isEnabled = true
                    self.submitButton.activityIndicator?.stopAnimating()
                }
        }) { (error) in
            log.error(["An unexpected error occurred loading uniforms", error])
            
            Notification.show(
                title: "Error",
                subtitle: "An unexpected error occurred loading uniforms, please try again later.",
                type: NotificationType.error)
        }
    }
    
    private func buildForm() {
        let selectableRowCellUpdate: ((_ cell: BaseCell, _ row: BaseRow) -> Void) = { cell, row in
            cell.textLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
        }
        
        self.form.removeAll()
        
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
        
        // For each uniform section, build the form section and add to the form
        self.orderItems.forEach { uniformGroup in
            let section = Section(uniformGroup.name)
            
            // For each uniform item, build the item and add to the section
            uniformGroup.items.forEach({ uniformItem in
                var baseRow : BaseRow
                
                if (uniformItem.sizes.count == 0) {
                    baseRow = CheckRow(uniformItem.key) { row in
                        row.title = uniformItem.name
                    }
                } else {
                    baseRow = PushRow<String>(uniformItem.key) { row in
                        row.title = uniformItem.name
                        row.selectorTitle = "Select size"
                        row.options = uniformItem.sizes
                        }.onPresent({ (_, presentingVC) -> () in
                            presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                        })
                }
                
                section.append(baseRow)
            })
            
            self.form.append(section)
        }
        
        self.form
            +++ Section("Your payment")
            /*<<< PushRow<String>("order_package") { row in
                row.title = "Package"
                row.selectorTitle = "Select your package"
                row.options = [
                    "Bronze",
                    "Bronze Plus",
                    "Silver",
                    "Silver Plus",
                    "Gold",
                    "Gold Plus"
                ]
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })*/
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
                }.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = Theme.colorError
                    }
                    self.checkCompleteForm()
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            +++ Section("Anything else we should know?")
            <<< TextAreaRow("additional")
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        guard let nameRow = self.form.rowBy(tag: "name") as? TextRow else {
            self.submitButton.isEnabled = false
            return
        }
        
        guard let studentRow = self.form.rowBy(tag: "student_name") as? TextRow else {
            self.submitButton.isEnabled = false
            return
        }
        
        guard let emailRow = self.form.rowBy(tag: "email") as? EmailRow else {
            self.submitButton.isEnabled = false
            return
        }
        
        guard let paymentMethodRow = self.form.rowBy(tag: "payment_method") as? PushRow<String> else {
            self.submitButton.isEnabled = false
            return
        }
        
        self.submitButton.isEnabled =
            nameRow.value != nil && nameRow.isValid
            && studentRow.value != nil && studentRow.isValid
            && emailRow.value != nil && emailRow.isValid
            && paymentMethodRow.value != nil && paymentMethodRow.isValid
    }
    
    @objc private func submitOrder(sender: Any?) {
        // Get a list of all (key,title) of items
        let orderItemIds = self.orderItems.flatMap { uniformGroup in
            return uniformGroup.items
        }
        
        // Turn the list of items (key,title) into a map of (title,size)
        let orderItems: [UniformItem : String?] = orderItemIds.reduce(into: [:]) { dict, uniformItem in
            // Get the value of the row, the orderItemId is the row's tag
            let rowValue = (self.form.rowBy(tag: uniformItem.key))?.baseValue
            
            // If row is a boolean then use that to indicate if it's ordered,
            // otherwise it's ordered if there is a value provided
            let rowOrdered = rowValue as? Bool ?? rowValue != nil
            
            // Only process the row if it's ordered
            if (rowOrdered) {
                // The row's value is the size, which could be a double or String
                // Boolean values are ignored as they do not represent a size
                var rowSize: String? = nil
                if (rowValue != nil) {
                    switch (rowValue) {
                    case is Double: rowSize = String(rowValue as! Double)
                    case is String: rowSize = (rowValue as! String)
                    default: rowSize = nil
                    }
                }
                
                // Add to the dictionary
                dict[uniformItem] = rowSize
            }
        }
        
        let name = (self.form.rowBy(tag: "name") as! TextRow).value!
        let studentName = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        let orderPackage = (self.form.rowBy(tag: "order_package") as! PushRow<String>).value
        let paymentMade = (self.form.rowBy(tag: "payment_made") as! SwitchRow).value ?? false
        let paymentMethod = (self.form.rowBy(tag: "payment_method") as! PushRow<String>).value!
        let additionalInfo = (self.form.rowBy(tag: "additional") as! TextAreaRow).value
        
        // Store name/student/email for next time
        Preferences.store(key: Preferences.KEY_NAME, value: name)
        Preferences.store(key: Preferences.KEY_STUDENT_NAME, value: studentName)
        Preferences.store(key: Preferences.KEY_EMAIL, value: email)
        
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submitButton.activityIndicator?.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            ServiceLocator.uniformService.orderUniform(
                name: name,
                studentName: studentName,
                email: email,
                package: orderPackage,
                paymentMade: paymentMade,
                paymentMethod: paymentMethod,
                additionalInfo: additionalInfo,
                orderItems: orderItems,
                successHandler: {
                    Notification.show(
                        title: "Success",
                        subtitle: "Your uniform order has been sent!",
                        type: NotificationType.success)
                    
                    DispatchQueue.main.async {
                        self.submitButton.isEnabled = true
                        self.submitButton.activityIndicator?.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                        
                        self.performSegue(withIdentifier: "unwindToHomeViewController", sender: sender)
                    }
                },
                errorHandler: { (error: Error) in
                    log.error(["An unexpected error occurred submitting order", error])
                    
                    Notification.show(
                        title: "Error",
                        subtitle: "An unexpected error occurred submitting your order, please try again later.",
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
