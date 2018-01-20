//
//  PaymentDetailsViewController.swift
//  Dance Trix
//
//  Created by Kelly-Anne Palmer on 20/01/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import UIKit

class PaymentDetailsViewController: AnalyticsUIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Set the navigation stack to be the first and last element only
        self.navigationController?.setViewControllers([(self.navigationController?.viewControllers.first)!, self], animated: false)
    }

}
