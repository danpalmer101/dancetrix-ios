//
//  HomeViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "AboutUs") {
            let destination: WebViewController = segue.destination as! WebViewController
            destination.url = "http://www.dancetrix.co.uk"
            destination.cssFileName = "dancetrix-body-only"
        }
    }
    
    // MARK: - Actions
    
    @IBAction
    func visitWebsite() {
        UIApplication.shared.open(URL(string: "http://www.dancetrix.co.uk")!)
    }
    
    @IBAction
    func unwindToHomeViewController(segue: UIStoryboardSegue) {
        
    }

}
