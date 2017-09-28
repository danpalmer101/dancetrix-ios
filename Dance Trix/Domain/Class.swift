//
//  Class.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class Class : Hashable, Equatable {
    
    var hashValue: Int
    
    //MARK: Properties
    
    var id: String
    var path: String
    var name: String
    
    //MARK: Initialization
    
    init?(id: String, path: String, name: String) {
        self.id = id
        self.path = path
        self.name = name
        
        self.hashValue = id.hashValue
    }
    
    static func ==(lhs: Class, rhs: Class) -> Bool {
        return lhs.id == rhs.id
    }
    
}
