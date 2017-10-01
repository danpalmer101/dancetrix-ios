//
//  UniformOrderViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka

class UniformOrderViewController: SubmitFormViewController {
    
    let childClothesSizes = [
        "3 - 4 years (Size 0)",
        "5 - 6 years (Size 1)",
        "7 - 8 years (Size 1b)",
        "9 - 10 years (Size 2)",
        "11 - 13 years (Size 3a)",
        "Adult Small (Size 3)",
        "Adult Medium (Size 4)",
        ]
    
    let childShoeSizes = [5, 6, 7, 8, 9, 9.5, 10, 10.5]
    
    let adultClothesSizes = [
        "Small",
        "Medium",
        "Large",
        "Extra Large"
    ]
    
    let adultShoeSizes = [4, 4.5, 5, 5.5, 6, 6.5, 7, 7.5]

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                }
            +++ Section("Order children's clothes")
            <<< PushRow<String>("child_turquoise_skirted_leotard") { row in
                row.title = "Turquoise skirted leotard"
                row.selectorTitle = "Select size"
                row.options = childClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<String>("child_turquoise_leggings") { row in
                row.title = "Turquoise leggings"
                row.selectorTitle = "Select size"
                row.options = childClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<String>("child_turquoise_skirt") { row in
                row.title = "Turquoise skirt"
                row.selectorTitle = "Select size"
                row.options = childClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<String>("child_dance_trix_branded_hoodie") { row in
                row.title = "Dance Trix branded hoodie"
                row.selectorTitle = "Select size"
                row.options = childClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<String>("child_dance_trix_branded_tshirt") { row in
                row.title = "Dance Trix branded t-shirt"
                row.selectorTitle = "Select size"
                row.options = childClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<String>("child_black_high_neck_leotard") { row in
                row.title = "Black high neck leotard"
                row.selectorTitle = "Select size"
                row.options = childClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            +++ Section("Order children's shoes")
            <<< PushRow<Double>("child_shoes_tap_white") { row in
                row.title = "White tap shoes"
                row.selectorTitle = "Select size"
                row.options = childShoeSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<Double>("child_shoes_tap_black") { row in
                row.title = "Black tap shoes"
                row.selectorTitle = "Select size"
                row.options = childShoeSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<Double>("child_pink_ballet_shoes") { row in
                row.title = "Pink ballet shoes"
                row.selectorTitle = "Select size"
                row.options = childShoeSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            +++ Section("Order adult's clothes")
            <<< PushRow<String>("adult_dance_trix_hoodie") { row in
                row.title = "Dance Trix hoodie"
                row.selectorTitle = "Select size"
                row.options = adultClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<String>("adult_dance_trix_tshirt") { row in
                row.title = "Dance Trix t-shirt"
                row.selectorTitle = "Select size"
                row.options = adultClothesSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            +++ Section("Order adult's shoes")
            <<< PushRow<Double>("adult_shoes_ballet") { row in
                row.title = "Ballet shoes"
                row.selectorTitle = "Select size"
                row.options = adultShoeSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< PushRow<Double>("adult_shoes_tap") { row in
                row.title = "Tap shoes"
                row.selectorTitle = "Select size"
                row.options = adultShoeSizes
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            +++ Section("Order other items")
            <<< PushRow<String>("pink_ballet_socks") { row in
                row.title = "Pink ballet socks"
                row.selectorTitle = "Select size"
                row.options = ["6 - 8.5", "9 - 12", "12.5 - 3"]
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            <<< CheckRow("child_ballet_bag") { row in
                row.title = "Child's ballet bag"
                }
            <<< CheckRow("adult_ballet_bag") { row in
                row.title = "Adult's ballet bag"
                }
            <<< CheckRow("child_ballet_purse") { row in
                row.title = "Child's ballet purse"
                }
            <<< CheckRow("exam_headband") { row in
                row.title = "Exam headband"
                }
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
                }.onPresent({ (_, presentingVC) -> () in
                    presentingVC.selectableRowCellUpdate = selectableRowCellUpdate
                })
            +++ Section("Anything else we should know?")
            <<< TextAreaRow("additional")
        
        self.submitButton.setTitle("Submit order", for: .normal)
        self.submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    @objc private func submit(sender: Any?) {
        log.info("Submit")
    }

}
