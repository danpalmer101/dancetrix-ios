//
//  SubmitFormViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka
import Firebase

class SubmitFormViewController: FormViewController {
    
    @IBInspectable var screenName : String?

    var submitButton: SubmitButton!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 87))
        
        self.submitButton = SubmitButton(parentView: footerView, title: "Submit")!
        footerView.addSubview(self.submitButton)
        self.tableView.tableFooterView = footerView
        
        self.tableView.separatorColor = .lightGray
        
        self.submitButton.overlayActivityIndicator()
    }
    
    // MARK: - View lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.screenName != nil) {
            Analytics.setScreenName(self.screenName, screenClass: nil)
        }
    }

}
