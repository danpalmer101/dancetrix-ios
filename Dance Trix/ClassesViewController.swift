//
//  ClassesViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class ClassesViewController: UITableViewController {
    
    var classMenu: ClassMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.classMenu?.children?.count
        
        return rows != nil ? rows! : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClassNode", for: indexPath)
        Theme.applyTableViewCell(tableCell: cell)
        
        // TODO: Configure the cell...
        cell.textLabel?.text = classMenu?.children![indexPath.row].name

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if (segue.identifier == "ViewChildren") {
            let destination: ClassesViewController = segue.destination as! ClassesViewController
            destination.classMenu = classMenu?.children![0] // TODO: Set based on selected child from 'sender'
        } else if (segue.identifier == "ViewClass") {
            // TODO
        }
    }

}
