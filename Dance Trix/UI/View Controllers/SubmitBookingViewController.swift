//
//  SubmitBookingViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class SubmitBookingViewController: UIViewController {

    var classDetails: Class!
    var dates: [DateInterval]!
    
    @IBOutlet
    var classesLabel: UILabel!
    @IBOutlet
    var datesLabel: UILabel!
    @IBOutlet
    var nameField: UITextField!
    @IBOutlet
    var emailField: UITextField!
    @IBOutlet
    var submitButton: UIButton!
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd MMM HH:mm"
        
        self.classesLabel.text = self.classDetails.path
        self.datesLabel.text = self.dates.map({
            (interval: DateInterval) -> String in return dateFormat.string(from: interval.start)
        }).joined(separator: ",")
        
        self.checkCompleteForm()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "Submit") {
            // TODO
        }
    }
    
    // MARK: - Actions
    
    @IBAction
    func checkCompleteForm() {
        self.submitButton.isEnabled = self.nameField.hasText && self.emailField.hasText
    }
    
}
