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
        //self.navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "Bookings") {
            let destination: ClassesViewController = segue.destination as! ClassesViewController
            // TODO : Load ClassMenu
            destination.classMenu = ClassMenuParser.parse(
                serviceNames: [
                    "Children|Friday Classes at Ingrave",
                    "Children|Saturday Classes|Autumn Half Term 1 2017",
                    "Children|Saturday Classes|Autumn Half Term 2 2017",
                    "Children|Saturday Classes|Spring Half Term 1 2018",
                    "Children|Saturday Classes|Spring Half Term 2 2018",
                    "Children|Saturday Classes|Summer Half Term 1 2018",
                    "Children|Saturday Classes|Summer Half Term 2 2018",
                    "Children|Tiny Trixies|Wickford|Autumn Half Term 1 2017",
                    "Children|Tiny Trixies|Wickford|Autumn Half Term 2 2017",
                    "Children|Tiny Trixies|Wickford|Spring Half Term 1 2018",
                    "Children|Tiny Trixies|Wickford|Spring Half Term 2 2018",
                    "Children|Tiny Trixies|Wickford|Summer Half Term 1 2018",
                    "Children|Tiny Trixies|Wickford|Summer Half Term 2 2018",
                    "Children|Tiny Trixies|Ingrave|Autumn Half Term 1 2017",
                    "Children|Tiny Trixies|Ingrave|Autumn Half Term 2 2017",
                    "Children|Tiny Trixies|Ingrave|Spring Half Term 1 2018",
                    "Children|Tiny Trixies|Ingrave|Spring Half Term 2 2018",
                    "Children|Tiny Trixies|Ingrave|Summer Half Term 1 2018",
                    "Children|Tiny Trixies|Ingrave|Summer Half Term 2 2018",
                    "Adults|Day Time Classes|Ballet & Tap",
                    "Adults|Day Time Classes|Mummy Ballet Burn",
                    "Adults|Evening Classes|Advanced Tap",
                    "Adults|Evening Classes|Advanced Ballet",
                    "Adults|Evening Classes|Beginners / Intermediate Ballet",
                    "Adults|Evening Classes|Intermediate Tap",
                    "Adults|Evening Classes|Beginners Tap",
                    "Adults|Evening Classes|Ballet Burn & Limbering",
                    "Adults|Evening Classes|Jazz",
                ]
            )
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
