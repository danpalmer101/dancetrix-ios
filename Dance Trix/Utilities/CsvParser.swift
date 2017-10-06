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
        let cleanCsv = clean(csv)
        
        // Filter out empty rows, and ignore the fist row which is assumed to be a header
        return Array(cleanCsv.components(separatedBy: "\n").dropFirst()).filter { trim($0) != "" }
    }
    
    static func columns(csvRow: String) -> [String] {
        return csvRow.components(separatedBy: ",")
    }
    
    static func clean(_ string: String) -> String {
        // Standardise new line characters
        return string
            .replacingOccurrences(of: "\r\n", with: "\n") // CR+LF -> LF
            .replacingOccurrences(of: "\n\r", with: "\n") // LF+CR -> LF
            .replacingOccurrences(of: "\r", with: "\n")   // CR    -> LF
    }
    
}
