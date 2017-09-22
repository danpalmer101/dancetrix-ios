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
    
}
