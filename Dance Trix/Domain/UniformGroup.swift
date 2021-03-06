//
//  UniformGroup.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class UniformGroup : Hashable, Equatable {
    
    //MARK: Properties
    
    var name : String
    var items : [UniformItem]
    
    //MARK: Initialization
    
    init(name: String, items: [UniformItem]) {
        self.name = name
        self.items = items
    }
    
    //MARK: Equatable
    
    static func ==(lhs: UniformGroup, rhs: UniformGroup) -> Bool {
        return lhs.name == rhs.name
    }
    
    //MARK: Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
}
