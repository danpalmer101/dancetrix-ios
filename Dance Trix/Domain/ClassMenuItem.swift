//
//  ClassMenuItem.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class ClassMenuItem {
    
    //MARK: Properties
    
    var name: String
    var children: [ClassMenuItem]?
    var classDetails: Class?
    
    //MARK: Initialization
    
    init?(name: String, classDetails: Class) {
        self.name = name
        self.classDetails = classDetails
    }
    
    init?(name: String, children: [ClassMenuItem]) {
        self.name = name
        self.children = children
    }
    
}
