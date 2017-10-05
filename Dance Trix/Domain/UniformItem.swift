//
//  UniformItem.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class UniformItem : Hashable, Equatable {
    
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
    
    convenience init(json: [String : Any?]) {
        self.init(key: json["key"] as! String,
                  name: json["name"] as! String,
                  sizes: (json["sizes"] as? [String]) ?? [])
    }
    
    //MARK: Equatable
    
    static func ==(lhs: UniformItem, rhs: UniformItem) -> Bool {
        return lhs.key == rhs.key
    }
    
}
