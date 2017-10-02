//
//  ClassMenuParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ClassMenuParser {
    
    private static let trimCharacters = CharacterSet(charactersIn: " ")
    
    static func parse(serviceNames: [String]) -> ClassMenu {
        var classMenus = [ClassMenu]()
        
        // Create a single branch ClassMenu tree for each 'serviceName'
        for serviceName in serviceNames {
            var split = serviceName.split(separator: "|", maxSplits: Int.max, omittingEmptySubsequences: true)
            
            let name = trim(String(split.popLast()!))
            let classDetails = Class(id: serviceName,
                                     path: serviceName.replacingOccurrences(of: "|", with: " > "),
                                     name: name)
            var classMenu = ClassMenu(name: name,
                                      classDetails: classDetails!)
            
            // Keep embedding class level in a parent
            for classLevel in split.reversed() {
                classMenu = ClassMenu(name: trim(String(classLevel)),
                                      children: [classMenu!])
            }
            
            classMenus.append(classMenu!)
        }
        
        return ClassMenu(name: "Classes", children: merge(classMenus: classMenus))!
    }
    
    private static func merge(classMenus: [ClassMenu]) -> [ClassMenu] {
        // Unique ClassMenu entries
        var mergedClassMenuDict = [String: ClassMenu]()
        
        // Each classMenu is a single child branch, common root nodes should be merged
        for classMenu in classMenus {
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
        return Array(mergedClassMenuDict.values).sorted(by: {
            (a, b) -> Bool in
                return a.name < b.name
            })
    }
    
    private static func trim(_ string: String) -> String {
        return string.trimmingCharacters(in: trimCharacters)
    }
    
}
