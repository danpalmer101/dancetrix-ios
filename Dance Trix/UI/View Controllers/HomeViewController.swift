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
    var registrationView: UIView!
    @IBOutlet
    var bookClassView: UIView!
    @IBOutlet
    var importantDatesView: UIView!
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
        
        self.hideMenuOptions()
        
        // Listen for updates to remote config in case the update is slow during app start up
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(hideMenuOptions),
                                               name: .remoteConfigUpdated,
                                               object: nil)
    }
    
    @objc private func hideMenuOptions() {
        self.stackView.removeArrangedSubview(self.registrationView)
        self.stackView.removeArrangedSubview(self.bookClassView)
        self.stackView.removeArrangedSubview(self.importantDatesView)
        self.stackView.removeArrangedSubview(self.calendarView)
        self.stackView.removeArrangedSubview(self.uniformView)
        self.stackView.removeArrangedSubview(self.paymentView)
        self.stackView.removeArrangedSubview(self.aboutView)
        
        //if (Configuration.registrationEnabled()) {
            self.stackView.addArrangedSubview(self.registrationView)
        //}
        if (Configuration.bookClassEnabled()) {
            self.stackView.addArrangedSubview(self.bookClassView)
        }
        if (Configuration.importantDatesEnabled()) {
            self.stackView.addArrangedSubview(self.importantDatesView)
        }
        if (Configuration.calendarEnabled()) {
            self.stackView.addArrangedSubview(self.calendarView)
        }
        if (Configuration.uniformEnabled()) {
            self.stackView.addArrangedSubview(self.uniformView)
        }
        if (Configuration.paymentEnabled()) {
            self.stackView.addArrangedSubview(self.paymentView)
        }
        if (Configuration.aboutEnabled()) {
            self.stackView.addArrangedSubview(self.aboutView)
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
