//
//  SubmitFormViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka

class SubmitFormViewController: FormViewController {

    var submitButton: SubmitButton!
    var submittingIndicator: UIActivityIndicatorView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 87))
        
        self.submitButton = SubmitButton(parentView: footerView, title: "Submit")!
        
        self.submittingIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        let width = submittingIndicator.frame.size.width
        let height = submittingIndicator.frame.size.height
        let buttonFrame = self.submitButton.frame
        self.submittingIndicator.frame = CGRect(
            x: buttonFrame.origin.x + ((buttonFrame.size.width - width) / 2),
            y: buttonFrame.origin.y + ((buttonFrame.size.height - height) / 2),
            width: width,
            height: height)
        
        footerView.addSubview(self.submitButton)
        footerView.addSubview(self.submittingIndicator)
        
        self.tableView.tableFooterView = footerView
    }

}
