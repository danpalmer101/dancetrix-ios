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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    };

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.classMenu?.children?.count
        
        return rows != nil ? rows! : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let child = classMenu?.children![indexPath.row]
        
        let identifier = child?.classDetails != nil ? "ClassLeaf" : "ClassNode"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        Theme.applyTableViewCell(tableCell: cell)
        
        cell.textLabel?.text = classMenu?.children![indexPath.row].name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        cell.tag = indexPath.row

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let cell = sender as! UITableViewCell
        
        if (segue.identifier == "ViewChildren") {
            let destination: ClassesViewController = segue.destination as! ClassesViewController
            destination.classMenu = classMenu?.children![cell.tag]
            destination.title = classMenu?.children![0].name
        } else if (segue.identifier == "ViewClass") {
            // TODO
        }
    }

}
