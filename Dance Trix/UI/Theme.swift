//
//  Theme.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import Eureka

class Theme {
    
    static let colorBackground = UIColor.black
    static let colorTint = UIColor(displayP3Red: 28.0/256.0, green:146.0/256.0, blue: 128.0/256.0, alpha: 1)
    static let colorTintDark = UIColor(displayP3Red: 14.0/256.0, green:73.0/256.0, blue: 64.0/256.0, alpha: 1)
    static let colorForeground = UIColor.white
    static let colorForegroundDark = UIColor.darkGray
    static let colorForegroundMid = UIColor.lightGray
    static let colorError = UIColor(displayP3Red: 0.8, green: 0, blue: 0, alpha: 1)
    
    static func applyGlobal(window: UIWindow?) {
        // Global
        window?.tintColor = Theme.colorForeground
        window?.backgroundColor = Theme.colorBackground
        
        // All Views
        UIView.appearance().backgroundColor = UIColor.clear
        
        // Background
        BackgroundView.appearance().backgroundColor = Theme.colorBackground
        
        // Nav Bars
        UINavigationBar.appearance().barTintColor = Theme.colorBackground
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:Theme.colorForeground]
        UITabBar.appearance().barTintColor = Theme.colorBackground
        
        // Tables
        let cellBackgroundView = UIView()
        cellBackgroundView.backgroundColor = Theme.colorForegroundDark
        UITableViewCell.appearance().selectedBackgroundView = cellBackgroundView
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor = Theme.colorForeground
        UITableView.appearance().backgroundColor = Theme.colorBackground
        
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).textColor = Theme.colorTint
        UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).font = UIFont.boldSystemFont(ofSize: 15)
        
        // Buttons
        LinkButton.appearance().tintColor = Theme.colorTint
        SubmitButton.appearance().backgroundColor = Theme.colorTint
        
        // Images
        TintImageView.appearance().tintColor = Theme.colorTint
        TintImageView.appearance(whenContainedInInstancesOf: [TintSelectTableViewCell.self]).tintColor = nil
        
        // Text
        UITextView.appearance().textColor = Theme.colorForeground
        UITextField.appearance().textColor = Theme.colorForeground
        UILabel.appearance().textColor = Theme.colorForeground
        
        // Eureka Forms
        TextRow.defaultCellSetup = { cell, row in
            cell.textField?.textColor = Theme.colorForeground
            cell.textLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
            row.placeholderColor = Theme.colorForegroundMid
        }
        TextRow.defaultCellUpdate = TextRow.defaultCellSetup
        
        TextAreaRow.defaultCellSetup = { cell, row in
            cell.textView?.textColor = Theme.colorForeground
            cell.textLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
        }
        TextAreaRow.defaultCellUpdate = TextAreaRow.defaultCellSetup
        
        EmailRow.defaultCellSetup = { cell, row in
            cell.textField?.textColor = Theme.colorForeground
            cell.textLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
            row.placeholderColor = Theme.colorForegroundMid
        }
        EmailRow.defaultCellUpdate = EmailRow.defaultCellSetup
        
        DecimalRow.defaultCellSetup = { cell, row in
            cell.textField?.textColor = Theme.colorForeground
            cell.textLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
            row.placeholderColor = Theme.colorForegroundMid
        }
        DecimalRow.defaultCellUpdate = DecimalRow.defaultCellSetup
        
        DateRow.defaultCellSetup = { cell, row in
            cell.textLabel?.textColor = Theme.colorForeground
            cell.detailTextLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
        }
        DateRow.defaultCellUpdate = DateRow.defaultCellSetup
        
        PushRow<String>.defaultCellSetup = { cell, row in
            cell.textLabel?.textColor = Theme.colorForeground
            cell.detailTextLabel?.textColor = Theme.colorForeground
            cell.tintColor = Theme.colorTint
        }
        PushRow<String>.defaultCellUpdate = PushRow<String>.defaultCellSetup
    }
    
    static func applyTableViewCell(tableCell: UITableViewCell?) {
        tableCell?.textLabel?.textColor = Theme.colorForeground
    }
    
}
