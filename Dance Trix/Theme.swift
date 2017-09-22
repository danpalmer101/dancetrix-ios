//
//  Theme.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class Theme {
    
    static func applyGlobal(window: UIWindow?) {
        // Global
        window?.tintColor = UIColor.white
        window?.backgroundColor = UIColor.black
        
        // All Views
        UIView.appearance().backgroundColor = UIColor.clear
        
        // Nav Bar
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        // Table
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = UIColor.white;
        UITableViewCell.appearance().selectedBackgroundView = cellBackgroundView;
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = UIColor.white
    }
    
    static func applyTableViewCell(tableCell: UITableViewCell?) {
        tableCell?.textLabel?.textColor = UIColor.white
    }
    
}
