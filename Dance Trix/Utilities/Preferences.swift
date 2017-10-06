//
//  Preferences.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class Preferences {
    
    static let KEY_NAME = "name"
    static let KEY_STUDENT_NAME = "student_name"
    static let KEY_EMAIL = "email"
    
    static let ALL = [KEY_NAME, KEY_STUDENT_NAME, KEY_EMAIL]

    static func cleanAll() {
        ALL.forEach { key in
            UserDefaults.standard.removeObject(forKey: key)
        }
    }
    
    static func store(key: String, value: Any?) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
}
