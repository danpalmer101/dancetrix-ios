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
        
        // TODO setup form
        
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
