//
//  HomeViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "Bookings") {
            let destination: ClassesViewController = segue.destination as! ClassesViewController
            // TODO : Load ClassMenu
            destination.classMenu = ClassMenu(serviceName: "Hello", childrenServiceNames: ["World|1", "World|2", "Test"])
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
