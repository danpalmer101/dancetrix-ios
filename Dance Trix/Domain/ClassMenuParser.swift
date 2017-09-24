//
//  ClassMenuParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ClassMenuParser {
    
    static func parse(serviceNames: [String]) -> ClassMenu {
        var classMenus = [ClassMenu]()
        
        // Create a single branch ClassMenu tree for each 'serviceName'
        for serviceName in serviceNames {
            var split = serviceName.split(separator: "|", maxSplits: Int.max, omittingEmptySubsequences: true)
            
            let name = String(split.popLast()!)
            let classDetails = Class(id: serviceName, name: name, dates: [
                DateRange(startDate: Date().addingTimeInterval(0), endDate: Date().addingTimeInterval(3600))!,
                DateRange(startDate: Date().addingTimeInterval(10000), endDate: Date().addingTimeInterval(13600))!,
                DateRange(startDate: Date().addingTimeInterval(20000), endDate: Date().addingTimeInterval(23600))!,
                DateRange(startDate: Date().addingTimeInterval(30000), endDate: Date().addingTimeInterval(33600))!,
                DateRange(startDate: Date().addingTimeInterval(40000), endDate: Date().addingTimeInterval(43600))!
            ])
            var classMenu = ClassMenu(name: name, classDetails: classDetails!)
            
            // Keep embedding class level in a parent
            for classLevel in split.reversed() {
                classMenu = ClassMenu(name: String(classLevel), children: [classMenu!])
            }
            
            classMenus.append(classMenu!)
        }
        
        return ClassMenu(name: "Classes", children: merge(classMenus: classMenus))!
    }
    
    static func merge(classMenus: [ClassMenu]) -> [ClassMenu] {
        var mergedClassMenuDict = [String: ClassMenu]()
        
        for classMenu in classMenus {
            let existingClassMenu = mergedClassMenuDict[classMenu.name]
            
            if (existingClassMenu == nil) {
                mergedClassMenuDict[classMenu.name] = classMenu
            } else {
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
        
        return Array(mergedClassMenuDict.values).sorted(by: {
            (a: ClassMenu, b: ClassMenu) -> Bool in
                return a.name < b.name
            })
    }
    
}
