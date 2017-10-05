//
//  UniformGroup.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import Mustache

class UniformGroup : Hashable, Equatable, MustacheBoxable {
    
    //MARK: Hashable
    
    var hashValue: Int
    
    //MARK: Properties
    
    var name : String
    var items : [UniformItem]
    
    //MARK: Initialization
    
    init(name: String, items: [UniformItem]) {
        self.name = name
        self.items = items
        
        self.hashValue = name.hashValue
    }
    
    //MARK: Equatable
    
    static func ==(lhs: UniformGroup, rhs: UniformGroup) -> Bool {
        return lhs.name == rhs.name
    }
    
    //MARK: Mustache
    
    var mustacheBox: MustacheBox {
        return Box(["name": self.name, "items": self.items])
    }
    
}
