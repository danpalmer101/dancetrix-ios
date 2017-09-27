//
//  HomeViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Actions
    
    @IBAction
    func visitWebsite() {
        UIApplication.shared.open(URL(string: "http://www.dancetrix.co.uk")!)
    }
    
    @IBAction
    func unwindToHomeViewController(segue: UIStoryboardSegue) {
        
    }

}
