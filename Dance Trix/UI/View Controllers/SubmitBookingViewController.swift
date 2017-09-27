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
    @IBOutlet
    var submittingIndicator: UIActivityIndicatorView!
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd MMM HH:mm"
        
        self.classesLabel.text = self.classDetails.path
        self.datesLabel.text = self.dates.map({
            (interval: DateInterval) -> String in return dateFormat.string(from: interval.start)
        }).joined(separator: ", ")
        
        self.checkCompleteForm()
    }
    
    // MARK: - Actions
    
    @IBAction
    func checkCompleteForm() {
        self.submitButton.isEnabled = self.nameField.hasText && self.emailField.hasText
    }
    
    @IBAction
    func submitBooking(sender: Any?) {
        let name = self.nameField.text!
        let email = self.emailField.text!
        let submitTitle = self.submitButton.title(for: .normal)
        
        self.submitButton.setTitle("", for: .normal)
        self.submittingIndicator.startAnimating()
        self.submitButton.isEnabled = false
        
        DispatchQueue.global().async {
            do {
                try _ = ServiceLocator.bookingService.bookClass(classDetails: self.classDetails,
                                                                dates: self.dates,
                                                                name: name,
                                                                email: email)
                
                DispatchQueue.main.async {
                    self.submitButton.isEnabled = true
                    self.submittingIndicator.stopAnimating()
                    self.submitButton.setTitle(submitTitle, for: .normal)
                    self.performSegue(withIdentifier: "unwindToHomeViewController", sender: sender)
                }
            } catch BookingError.errorBooking(_, _) {
                // TODO
                DispatchQueue.main.async {
                    self.submitButton.isEnabled = true
                    self.submittingIndicator.stopAnimating()
                    self.submitButton.setTitle(submitTitle, for: .normal)
                }
            } catch {
                // TODO
                DispatchQueue.main.async {
                    self.submitButton.isEnabled = true
                    self.submittingIndicator.stopAnimating()
                    self.submitButton.setTitle(submitTitle, for: .normal)
                }
            }
        }
    }
    
}
