//
//  HomeViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class HomeViewController: AnalyticsUIViewController {
    
    @IBOutlet
    var stackView: UIStackView!
    
    @IBOutlet
    var bookClassView: UIView!
    @IBOutlet
    var calendarView: UIView!
    @IBOutlet
    var uniformView: UIView!
    @IBOutlet
    var paymentView: UIView!
    @IBOutlet
    var aboutView: UIView!
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!Configuration.bookClassEnabled()) {
            self.stackView.removeArrangedSubview(self.bookClassView)
        }
        if (!Configuration.calendarEnabled()) {
            self.stackView.removeArrangedSubview(self.calendarView)
        }
        if (!Configuration.uniformEnabled()) {
            self.stackView.removeArrangedSubview(self.uniformView)
        }
        if (!Configuration.paymentEnabled()) {
            self.stackView.removeArrangedSubview(self.paymentView)
        }
        if (!Configuration.aboutEnabled()) {
            self.stackView.removeArrangedSubview(self.aboutView)
        }
    }
    
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
