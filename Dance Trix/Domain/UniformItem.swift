//
//  UniformItem.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import Mustache

class UniformItem : Hashable, Equatable, MustacheBoxable {
    
    //MARK: Hashable
    
    var hashValue: Int
    
    //MARK: Properties
    
    var key : String
    var name : String
    var sizes : [String]
    
    //MARK: Initialization
    
    init(key: String, name: String, sizes: [String]) {
        self.key = key
        self.name = name
        self.sizes = sizes
        
        self.hashValue = key.hashValue
    }
    
    //MARK: Equatable
    
    static func ==(lhs: UniformItem, rhs: UniformItem) -> Bool {
        return lhs.key == rhs.key
    }
    
    //MARK: Mustache
    
    var mustacheBox: MustacheBox {
        return Box(["key": self.key, "name": self.name, "sizes": self.sizes])
    }
    
}
