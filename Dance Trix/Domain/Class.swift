//
//  Class.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class Class {
    
    //MARK: Properties
    
    var id: String
    var name: String
    
    //MARK: Initialization
    
    init?(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
}
