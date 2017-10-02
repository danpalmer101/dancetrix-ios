//
//  ClassDatesParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ClassDatesParser {

    private static let trimCharacters = CharacterSet(charactersIn: " ")

    static func parse(csvString: String) -> [DateInterval] {
        var dates = [DateInterval]()
        
        let csvRows = csvString.components(separatedBy: "\n")
        
        for csvRow in csvRows {
            if (trim(csvRow) == "") {
                // Skip empty rows
                continue
            }
            
            let csvColumns = csvRow.components(separatedBy: ",")
            let format = csvColumns[0]
            
            var date: DateInterval?
            
            switch (format) {
            case "V1": date = parseFormat1(csvRow: csvColumns)
            default: log.warning(["Unrecognised Class Date CSV format", format])
            }
            
            if (date != nil) {
                dates.append(date!)
            }
        }
        
        return dates
    }
    
    private static func parseFormat1(csvRow: [String]) -> DateInterval? {
        let date = trim(csvRow[1])
        let time = trim(csvRow[2])
        let duration = trim(csvRow[3])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let startDate = dateFormatter.date(from: date + " " + time)
        
        // Ignore past dates
        if startDate! < Date() {
            return nil
        }
        
        return DateInterval(start: startDate!, duration: Double(duration)! * 60)
    }
    
    private static func trim(_ string: String) -> String {
        return string.trimmingCharacters(in: trimCharacters)
    }

}
