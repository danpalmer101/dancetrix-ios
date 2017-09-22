//
//  ClassMenu.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class ClassMenu {
    
    //MARK: Properties
    
    var name: String
    var children: [ClassMenu]?
    var classDetails: Class?
    
    //MARK: Initialization
    
    init?(name: String, classDetails: Class) {
        self.name = name
        self.classDetails = classDetails
    }
    
    init?(name: String, children: [ClassMenu]) {
        self.name = name
        self.children = children
    }
    
    init?(serviceName: String, childrenServiceNames: [String]) {
        self.name = serviceName;
        
        if (!childrenServiceNames.isEmpty) {
            var parentChildDict = [String: [String]]()
            
            for serviceName in childrenServiceNames {
                var split = serviceName.split(separator: "|", maxSplits: 1, omittingEmptySubsequences: true)
                let parent = String(split[0])
                let child = split.count > 1 ? [String(split[1])] : [String]()
            
                parentChildDict[parent]?.append(contentsOf: child) ?? (parentChildDict[parent] = child)
            }
            
            self.children = [ClassMenu]()
            for (parent, children) in parentChildDict {
                self.children?.append(ClassMenu(serviceName: parent, childrenServiceNames: children)!)
            }
        } else {
            self.classDetails = Class(id: serviceName, name: serviceName)
        }
    }
    
}
