//
//  ImportantDatesViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 19/01/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import UIKit

class ImportantDatesViewController: AnalyticsUIViewController, UITableViewDelegate, UITableViewDataSource {

    private var dates: [(String, DateInterval)]?
    private var selectedDates: [IndexPath]?
    
    @IBOutlet
    var tableView: UITableView!

    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadDates()
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let date = self.dates?[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImportantDate", for: indexPath)
        Theme.applyTableViewCell(tableCell: cell)
        
        let selected = selectedDates?.contains(indexPath) ?? false
        
        cell.textLabel?.text = date?.0
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.detailTextLabel?.text = selected && date?.1.duration ?? 0 > 0 ? date?.1.asTimeOnlyText() : date?.1.asDateOnlyText()
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.detailTextLabel?.textColor = Theme.colorTint
        cell.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView(tableView, didToggleRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.tableView(tableView, didToggleRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didToggleRowAt indexPath: IndexPath) {
        self.selectedDates = tableView.indexPathsForSelectedRows
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        self.selectedDates?.forEach({ (row) in
            tableView.selectRow(at: row, animated: false, scrollPosition: .none)
        })
    }
    
    private func loadDates() {
        if (self.dates == nil) {
            DispatchQueue.global().async {
                ServiceLocator.classService.getImportantDates(
                    successHandler: { (dates) in
                        self.dates = dates
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    },
                    errorHandler: { (error) in });
            }
        }
    }
    
}
