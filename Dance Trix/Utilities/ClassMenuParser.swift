//
//  ClassMenuParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ClassMenuParser : CsvParser {
    
    static func parse(csvString: String) -> ClassMenu {
        let csvRows = rows(csv: csvString)
        
        let classMenus = csvRows.map({ csvRow -> ClassMenu? in
            let csvColumns = columns(csvRow: csvRow)
            let format = csvColumns[0]
            
            var classMenu: ClassMenu?
            
            switch (format) {
                case "V1": classMenu = parseFormat1(csvRow: csvColumns)
                default: log.warning(["Unrecognised ClassMenu CSV format", format])
            }
            
            return classMenu
        }).filter({ $0 != nil }) // ClassMenu cannot be null
            .map({ $0! }) // Unbox optionals now nulls are filtered out
        
        return ClassMenu(name: "Classes", children: merge(classMenus: classMenus))!
    }
    
    private static func merge(classMenus: [ClassMenu]) -> [ClassMenu] {
        // Each classMenu is a single child branch, common root nodes should be merged
        let merged: [String : ClassMenu] = classMenus.reduce(into: [:]) { mergedClassMenuDict, classMenu in
            let existingClassMenu = mergedClassMenuDict[classMenu.name]
            if existingClassMenu == nil {
                // Unique root node (so far), add it to the map
                mergedClassMenuDict[classMenu.name] = classMenu
            } else {
                // Common root node found, merge the children and add to the existing menu item in the map
                var children = [ClassMenu]()
                if (existingClassMenu?.children != nil) {
                    children += (existingClassMenu?.children)!
                }
                if (classMenu.children != nil) {
                    children += (classMenu.children)!
                }
                existingClassMenu?.children = merge(classMenus: children)
                if (classMenu.classDetails != nil) {
                    existingClassMenu?.classDetails = classMenu.classDetails
                }
            }
        }
        
        // Return the merged ClassMenu, sorted by name
        return Array(merged.values).sorted(by: {
            (a, b) -> Bool in
                return a.name < b.name
            })
    }

    private static func parseFormat1(csvRow: [String]) -> ClassMenu? {
        // Create a single branch ClassMenu tree
        let name = trim(csvRow[1])
        let menuPath = csvRow[2].components(separatedBy: "|").map { (s: String) -> String in return trim(s) }
        let datesLocation = trim(csvRow[3])
        let descriptionLocation = trim(csvRow[4])
        
        let classDetails = Class(id: csvRow.joined(separator: ","),
                                 path: menuPath.joined(separator: " > "),
                                 name: name,
                                 datesLocation: datesLocation,
                                 descriptionLocation: descriptionLocation)
        
        var classMenu = ClassMenu(name: name,
                                  classDetails: classDetails!)
        
        // Keep embedding class level in a parent
        for menuLevel in menuPath.reversed() {
            classMenu = ClassMenu(name: menuLevel,
                                  children: [classMenu!])
        }
        
        return classMenu
    }
    
}
