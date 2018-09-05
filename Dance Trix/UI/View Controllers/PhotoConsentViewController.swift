//
//  PhotoConsentViewController.swift
//  Dance Trix
//
//  Created by Kelly-Anne Palmer on 20/01/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import UIKit

class PhotoConsentViewController: AnalyticsUIViewController {
    
    var registration: RegistrationChild?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Signature") {
            let signatureViewController = (segue.destination as! SignatureViewController)
            signatureViewController.registrationChild = registration
        }
    }
    
    @IBAction
    func consentYes(sender: UIButton?) {
        registration?.consent = "Yes"
    }

    @IBAction
    func consentNo(sender: UIButton?) {
        registration?.consent = "No"
    }
    
    @IBAction
    func consentUnidentified(sender: UIButton?) {
        registration?.consent = "Yes, non-identifiable"
    }
    
}
