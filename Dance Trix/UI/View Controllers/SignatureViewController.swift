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
    @IBOutlet var registerButton : UIButton?
    
    var registrationAdult: RegistrationAdult?
    var registrationChild: RegistrationChild?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signatureView?.delegate = self
        
        self.registerButton?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        
    }
    
    func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView) {
        self.registerButton?.isEnabled = true
    }
    
    @IBAction func clear() {
        self.signatureView?.clear()
    }

}
