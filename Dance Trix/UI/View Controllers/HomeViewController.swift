//
//  HomeViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class HomeViewController: AnalyticsUIViewController {
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "AboutUs") {
            let destination: WebViewController = segue.destination as! WebViewController
            destination.url = Configuration.websiteUrl()
            destination.cssFileName = "dancetrix-body-only"
        } else if (segue.identifier == "OrderUniforms") {
            let destination: WebViewController = segue.destination as! WebViewController
            destination.url = Configuration.uniformCatalogUrl()
        }
    }
    
    // MARK: - Actions
    
    @IBAction
    func visitWebsite() {
        UIApplication.shared.open(URL(string: Configuration.websiteUrl())!)
    }
    
    @IBAction
    func unwindToHomeViewController(segue: UIStoryboardSegue) {
        
    }

}
