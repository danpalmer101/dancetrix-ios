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
    
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan: UIPanGestureRecognizer) {
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
        
        self.registrationAdult?.signature = self.signatureView?.signature
        self.registrationChild?.signature = self.signatureView?.signature
        
        DispatchQueue.global().async {
            let successHandler = {
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
            
            let errorHandler = { (error : Error) in
                log.error(["An unexpected error occurred submitting order", error])
                
                Notification.show(
                    title: "Error",
                    subtitle: "An unexpected error submitting your registration, please try again later.",
                    type: NotificationType.error)
                
                DispatchQueue.main.async {
                    self.registerButton!.isEnabled = true
                    self.registerButton!.activityIndicator?.stopAnimating()
                    self.registerButton!.setTitle(registerTitle, for: .normal)
                }
            }
            
            if (self.registrationAdult != nil) {
                ServiceLocator.registrationService.registerAdult(
                    registration: self.registrationAdult!,
                    successHandler: successHandler,
                    errorHandler: errorHandler)
            }
            
            if (self.registrationChild != nil) {
                ServiceLocator.registrationService.registerChild(
                    registration: self.registrationChild!,
                    successHandler: successHandler,
                    errorHandler: errorHandler)
            }
        }
    }

}
