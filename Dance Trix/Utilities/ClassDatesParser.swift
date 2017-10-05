//
//  ClassDatesParser.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ClassDatesParser : CsvParser {

    static func parse(csvString: String) -> [DateInterval] {
        let csvRows = rows(csv: csvString)
        
        return csvRows.map({ csvRow -> DateInterval? in
            let csvColumns = columns(csvRow: csvRow)
            let format = csvColumns[0]
            
            var date: DateInterval?
            
            switch (format) {
                case "V1": date = parseFormat1(csvRow: csvColumns)
                default: log.warning(["Unrecognised Class Date CSV format", format])
            }
            
            return date
        }).filter({ date -> Bool in
            // Date must exist and be in the future
            return date != nil && date!.start >= Date()
        }).map({ $0! })
    }
    
    private static func parseFormat1(csvRow: [String]) -> DateInterval? {
        let date = trim(csvRow[1])
        let time = trim(csvRow[2])
        let duration = trim(csvRow[3])
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        let startDate = dateFormatter.date(from: date + " " + time)
        
        return DateInterval(start: startDate!, duration: Double(duration)! * 60)
    }

}
