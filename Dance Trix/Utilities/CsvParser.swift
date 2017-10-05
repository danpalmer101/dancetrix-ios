//
//  CsvParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 05/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class CsvParser {
    
    private static let trimCharacters = CharacterSet(charactersIn: " ")
    
    static func trim(_ string: String) -> String {
        return string.trimmingCharacters(in: trimCharacters)
    }
    
    static func rows(csv: String) -> [String] {
        // Filter out empty rows
        return csv.components(separatedBy: "\n").filter { trim($0) != "" }
    }
    
    static func columns(csvRow: String) -> [String] {
        return csvRow.components(separatedBy: ",")
    }
    
}
