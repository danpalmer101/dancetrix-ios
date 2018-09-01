//
//  UniformParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 01/09/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation

class UniformParser : CsvParser {
    
    static func parse(csvString: String) -> [UniformGroup] {
        let csvRows = rows(csv: csvString)
        
        let uniformItems = csvRows.map({ csvRow -> (String, UniformItem)? in
            let csvColumns = columns(csvRow: csvRow)
            let format = csvColumns[0]
            
            var uniformItem: (String, UniformItem)?
            
            switch (format) {
                case "V1": uniformItem = parseFormat1(csvRow: csvColumns)
                default: log.warning(["Unrecognised UniformItem CSV format", format])
            }
            
            return uniformItem
        }).filter({ $0 != nil }) // UniformItem cannot be null
            .map({ $0! }) // Unbox optionals now nulls are filtered out
        
        return merge(uniformItems: uniformItems)
    }
    
    private static func merge(uniformItems: [(String, UniformItem)]) -> [UniformGroup] {
        // List to maintain the order of the groups
        var groupNames = [String]()
        
        let merged: [String : [UniformItem]] = uniformItems.reduce(into: [:]) { mergedUniformItemsDict, uniformItem in
            if let existingGroup = mergedUniformItemsDict[uniformItem.0] {
                // Common section found, merge the items
                mergedUniformItemsDict[uniformItem.0] = existingGroup + [uniformItem.1]
            } else {
                // Unique section (so far), add it to the map
                mergedUniformItemsDict[uniformItem.0] = [uniformItem.1]
                groupNames.append(uniformItem.0)
            }
        }
        
        return groupNames.map { (groupName) -> UniformGroup in
            return UniformGroup(name: groupName, items: merged[groupName]!)
        }
    }

    private static func parseFormat1(csvRow: [String]) -> (String, UniformItem)? {
        let section = trim(csvRow[1])
        let id = trim(csvRow[2])
        let name = trim(csvRow[3])
        
        let sizes: [String]
            
        if (trim(csvRow[4]).isEmpty) {
            sizes = []
        } else {
            sizes = csvRow[4].components(separatedBy: "|").map { (s: String) -> String in return trim(s) }
        }
        
        let uniformItem = UniformItem(key: id, name: name, sizes: sizes)
        
        return (section, uniformItem)
    }
    
}
