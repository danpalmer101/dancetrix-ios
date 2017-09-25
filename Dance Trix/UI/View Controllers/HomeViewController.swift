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
        
        if (segue.identifier == "Bookings") {
            let destination: ClassesViewController = segue.destination as! ClassesViewController
            // TODO : Load ClassMenu
            destination.classMenu = ClassMenuParser.parse(serviceNames: ["Hello|World|1","Hello|World|2","Hello|Earth"])
        } else if (segue.identifier == "Calendar") {
            // TODO
        }
    }
    
    // MARK: - Actions
    
    @IBAction
    func visitWebsite() {
        UIApplication.shared.open(URL(string: "http://www.dancetrix.co.uk")!)
    }

}
