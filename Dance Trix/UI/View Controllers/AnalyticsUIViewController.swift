//
//  StoryboardUIViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Firebase

class AnalyticsUIViewController: UIViewController {

    var screenName : String?
    
    // MARK: - View lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (self.screenName != nil) {
            Analytics.setScreenName(self.screenName, screenClass: nil)
        }
    }
    
}
