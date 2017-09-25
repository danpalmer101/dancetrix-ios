//
//  Theme.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class Theme {
    
    static let colorBackground = UIColor.black
    static let colorTint = UIColor(displayP3Red: 28.0/256.0, green:146.0/256.0, blue: 128.0/256.0, alpha: 1)
    static let colorTintDark = UIColor(displayP3Red: 14.0/256.0, green:73.0/256.0, blue: 64.0/256.0, alpha: 1)
    static let colorForeground = UIColor.white
    
    static func applyGlobal(window: UIWindow?) {
        // Global
        window?.tintColor = Theme.colorForeground
        window?.backgroundColor = Theme.colorBackground
        
        // All Views
        UIView.appearance().backgroundColor = UIColor.clear
        
        // Nav Bars
        UINavigationBar.appearance().barTintColor = Theme.colorBackground
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:Theme.colorForeground]
        
        // Tables
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = Theme.colorForeground
        UITableViewCell.appearance().selectedBackgroundView = cellBackgroundView
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = Theme.colorForeground
        UITableView.appearance().backgroundColor = Theme.colorBackground
        
        // Buttons
        LinkButton.appearance().tintColor = Theme.colorTint
        SubmitButton.appearance().backgroundColor = Theme.colorTint
        SubmitButton.appearance().backgroundColor = Theme.colorTint
        
        // Images
        TintImageView.appearance().tintColor = Theme.colorTint
        TintImageView.appearance(whenContainedInInstancesOf: [TintSelectTableViewCell.self]).tintColor = nil
    }
    
    static func applyTableViewCell(tableCell: UITableViewCell?) {
        tableCell?.textLabel?.textColor = Theme.colorForeground
    }
    
}
