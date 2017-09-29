//
//  ClassesViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import RMessage

class ClassesViewController: UITableViewController {
    
    var classMenu: ClassMenu?
    
    var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.loadingIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        self.loadingIndicator.hidesWhenStopped = true
        
        self.view.addSubview(self.loadingIndicator)
        
        self.loadClassMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadingIndicator.frame = CGRect(x: (self.view.frame.size.width - self.loadingIndicator.frame.size.width) / 2,
                                             y: 30,
                                             width: self.loadingIndicator.frame.size.width,
                                             height: self.loadingIndicator.frame.size.height)
    }

    // MARK: - Table view data source

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
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.tag = indexPath.row

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let cell = sender as! UITableViewCell
        
        if (segue.identifier == "ViewChildren") {
            let destination: ClassesViewController = segue.destination as! ClassesViewController
            destination.classMenu = self.classMenu?.children![cell.tag]
            destination.title = self.classMenu?.children![cell.tag].name
        } else if (segue.identifier == "ViewClass") {
            let destination: ClassDatesViewController = segue.destination as! ClassDatesViewController
            destination.classDetails = self.classMenu?.children![cell.tag].classDetails
        }
    }
    
    // MARK: - Actions
    
    func loadClassMenu() {
        if (self.classMenu == nil) {
            self.loadingIndicator.startAnimating()
            
            DispatchQueue.global().async {
                do {
                    try self.classMenu = ServiceLocator.classService.getClassMenu()
                } catch ClassesError.noClasses {
                    log.warning("No classes found")
                    
                    DispatchQueue.main.async {
                        RMessage.showNotification(withTitle: "Sorry!",
                                                  subtitle: "There aren't any dance classes that can be booked at the moment.",
                                                  type: RMessageType.warning,
                                                  customTypeName: nil,
                                                  callback: nil)
                    }
                } catch {
                    log.error(["An unexpected error occurred loading classes", error])
                    
                    DispatchQueue.main.async {
                        RMessage.showNotification(withTitle: "Error",
                                                  subtitle: "An unexpected error occurred loading our dance classes, please try again later.",
                                                  type: RMessageType.error,
                                                  customTypeName: nil,
                                                  callback: nil)
                    }
                }
        
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            }
        }
    }

}
