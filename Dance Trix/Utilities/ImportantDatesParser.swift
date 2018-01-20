//
//  ImportantDatesParser.swift
//  Dance Trix
//
//  Created by Kelly-Anne Palmer on 20/01/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation

class ImportantDatesParser : CsvParser {
    
    static func parse(csvString: String) -> [(String, DateInterval)] {
        let csvRows = rows(csv: csvString)
        
        return csvRows.map({ csvRow -> (String, DateInterval)? in
            let csvColumns = columns(csvRow: csvRow)
            let format = csvColumns[0]
            
            var date: (String, DateInterval)?
            
            switch (format) {
            case "V1": date = parseFormat1(csvRow: csvColumns)
            default: log.warning(["Unrecognised Class Date CSV format", format])
            }
            
            return date
        }).filter({ $0 != nil }) // Date cannot be null
            .map({ $0! }) // Unbox optionals now nulls are filtered out
            .filter({ $0.1.start >= Date() }) // Date cannot be in the past
    }
    
    private static func parseFormat1(csvRow: [String]) -> (String, DateInterval)? {
        let description = trim(csvRow[1])
        let date = trim(csvRow[2])
        let time = trim(csvRow[3])
        let duration = trim(csvRow[4])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let startDate = dateFormatter.date(from: date + " " + time)
        
        return (description, DateInterval(start: startDate!, duration: Double(duration)! * 60))
    }
    
}
