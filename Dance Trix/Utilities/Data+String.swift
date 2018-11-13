//
//  Data+String.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 13/11/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation

extension Data {
    
    func asString() -> String? {
        if let utf8String = String(data: self, encoding: String.Encoding.utf8) {
            return utf8String
        } else if let cp1252String = String(data: self, encoding: String.Encoding.windowsCP1252) {
            return cp1252String
        } else {
            return nil
        }
    }
    
}
