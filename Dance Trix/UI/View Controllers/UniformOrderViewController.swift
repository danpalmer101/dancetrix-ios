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

    var orderItems : [(String, [(String, String, [String])])]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderItems = ServiceLocator.orderService.getUniformOrderItems()
        
        let selectableRowCellUpdate: ((_ cell: BaseCell, _ row: BaseRow) -> Void) = { cell, row in
            cell.textLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
        }
        
        self.form
            +++ Section("Your details")
            <<< TextRow("name") { row in
                row.title = "Your name"
                row.placeholder = "Enter your name"
                row.add(rule: RuleRequired())
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
        
        // For each uniform section, build the form section and add to the form
        self.orderItems.forEach { (sectionName, items) in
            let section = Section(sectionName)
            
            // For each uniform item, build the item and add to the section
            items.forEach({ (key, title, sizes) in
                var baseRow : BaseRow
                
                if (sizes.count == 0) {
                    baseRow = CheckRow(key) { row in
                            row.title = title
                        }
                } else {
                    baseRow = PushRow<String>(key) { row in
                            row.title = title
                            row.selectorTitle = "Select size"
                            row.options = sizes
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
            <<< PushRow<String>("order_package") { row in
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
                })
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
        
        self.submitButton.setTitle("Submit order", for: .normal)
        self.submitButton.addTarget(self, action: #selector(submitOrder), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Analytics.setScreenName("Uniform Order", screenClass: nil)
    }
    
    // MARK: - Actions
    
    private func checkCompleteForm() {
        let nameRow = self.form.rowBy(tag: "name") as! TextRow
        let studentRow = self.form.rowBy(tag: "student_name") as! TextRow
        let emailRow = self.form.rowBy(tag: "email") as! EmailRow
        let paymentMethodRow = self.form.rowBy(tag: "payment_method") as! PushRow<String>
        
        self.submitButton.isEnabled =
            nameRow.value != nil && nameRow.isValid
            && studentRow.value != nil && studentRow.isValid
            && emailRow.value != nil && emailRow.isValid
            && paymentMethodRow.value != nil && paymentMethodRow.isValid
    }
    
    @objc private func submitOrder(sender: Any?) {
        // Get a list of all (key,title) of items
        let orderItemIds = self.orderItems.flatMap { (key, value) in
            return value.map({ (key, title, sizes) -> (String, String) in
                return (key, title)
            })
        }
        
        // Turn the list of items (key,title) into a map of (title,size)
        let orderItems: [String : String?] = orderItemIds.reduce(into: [:]) { dict, orderItemId in
            let (itemKey, itemTitle) = orderItemId
            
            // Get the value of the row, the orderItemId is the row's tag
            let rowValue = (self.form.rowBy(tag: itemKey))?.baseValue
            
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
                dict[itemTitle] = rowSize
            }
        }
        
        let name = (self.form.rowBy(tag: "name") as! TextRow).value!
        let student = (self.form.rowBy(tag: "student_name") as! TextRow).value!
        let email = (self.form.rowBy(tag: "email") as! EmailRow).value!
        let orderPackage = (self.form.rowBy(tag: "order_package") as! PushRow<String>).value
        let paymentMade = (self.form.rowBy(tag: "payment_made") as! SwitchRow).value ?? false
        let paymentMethod = (self.form.rowBy(tag: "payment_method") as! PushRow<String>).value!
        let additionalInfo = (self.form.rowBy(tag: "additional") as! TextAreaRow).value
        
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submittingIndicator.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            ServiceLocator.orderService.orderUniform(
                name: name,
                studentName: student,
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
                        self.submittingIndicator.stopAnimating()
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
                        self.submittingIndicator.stopAnimating()
                        self.submitButton.setTitle(submitTitle, for: .normal)
                    }
                })
        }
    }

}
