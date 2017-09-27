//
//  SubmitBookingViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class SubmitBookingViewController: UIViewController {

    var classDetails: Class?
    var dates: [DateInterval]?
    
    @IBOutlet
    var classesLabel: UILabel?
    @IBOutlet
    var datesLabel: UILabel?
    @IBOutlet
    var nameField: UITextField?
    @IBOutlet
    var emailField: UITextField?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM HH:mm"
        
        self.classesLabel?.text = self.classDetails?.path
        self.datesLabel?.text = self.dates?.map({ (interval: DateInterval) -> String in
            return dateFormat.string(from: interval.start)
        }).joined(separator: ",")
    }
    
}
