//
//  SignatureViewController.swift
//  Dance Trix
//
//  Created by Kelly-Anne Palmer on 20/01/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import UIKit
import SwiftSignatureView

class SignatureViewController: AnalyticsUIViewController, SwiftSignatureViewDelegate {
    
    @IBOutlet var signatureView : SignatureView?
    @IBOutlet var registerButton : SubmitButton?
    
    var registrationAdult: RegistrationAdult?
    var registrationChild: RegistrationChild?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signatureView?.delegate = self
        
        self.registerButton?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.registerButton!.overlayActivityIndicator()
    }
    
    func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        
    }
    
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView) {
        self.registerButton?.isEnabled = true
    }
    
    @IBAction func clear() {
        self.signatureView?.clear()
        self.registerButton?.isEnabled = false
    }
    
    @IBAction func register(sender: Any?) {
        let registerTitle = self.registerButton!.title(for: .normal)
        
        self.registerButton!.setTitle("", for: .normal)
        self.registerButton!.activityIndicator?.startAnimating()
        self.registerButton!.isEnabled = false
        
        DispatchQueue.global().async {
            // TODO
            
            Notification.show(
                title: "Success",
                subtitle: "Thankyou for registering!",
                type: NotificationType.success)
            
            DispatchQueue.main.async {
                self.registerButton!.isEnabled = true
                self.registerButton!.activityIndicator?.stopAnimating()
                self.registerButton!.setTitle(registerTitle, for: .normal)
                
                self.performSegue(withIdentifier: "unwindToHomeViewController", sender: sender)
            }
        }
    }

}
