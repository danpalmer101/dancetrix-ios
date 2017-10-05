//
//  Preferences.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class Preferences {

    static func store(key: String, value: Any?) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
}
