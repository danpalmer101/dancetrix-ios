//
//  ClassServices.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ClassService {
    
    func getClassMenu() throws -> ClassMenu {
        // TODO
        sleep(2)
        
        return ClassMenuParser.parse(
            serviceNames: [
                "Children|Friday Classes at Ingrave",
                "Children|Saturday Classes|Autumn Half Term 1 2017",
                "Children|Saturday Classes|Autumn Half Term 2 2017",
                "Children|Saturday Classes|Spring Half Term 1 2018",
                "Children|Saturday Classes|Spring Half Term 2 2018",
                "Children|Saturday Classes|Summer Half Term 1 2018",
                "Children|Saturday Classes|Summer Half Term 2 2018",
                "Children|Tiny Trixies|Wickford|Autumn Half Term 1 2017",
                "Children|Tiny Trixies|Wickford|Autumn Half Term 2 2017",
                "Children|Tiny Trixies|Wickford|Spring Half Term 1 2018",
                "Children|Tiny Trixies|Wickford|Spring Half Term 2 2018",
                "Children|Tiny Trixies|Wickford|Summer Half Term 1 2018",
                "Children|Tiny Trixies|Wickford|Summer Half Term 2 2018",
                "Children|Tiny Trixies|Ingrave|Autumn Half Term 1 2017",
                "Children|Tiny Trixies|Ingrave|Autumn Half Term 2 2017",
                "Children|Tiny Trixies|Ingrave|Spring Half Term 1 2018",
                "Children|Tiny Trixies|Ingrave|Spring Half Term 2 2018",
                "Children|Tiny Trixies|Ingrave|Summer Half Term 1 2018",
                "Children|Tiny Trixies|Ingrave|Summer Half Term 2 2018",
                "Adults|Day Time Classes|Ballet & Tap",
                "Adults|Day Time Classes|Mummy Ballet Burn",
                "Adults|Evening Classes|Advanced Tap",
                "Adults|Evening Classes|Advanced Ballet",
                "Adults|Evening Classes|Beginners / Intermediate Ballet",
                "Adults|Evening Classes|Intermediate Tap",
                "Adults|Evening Classes|Beginners Tap",
                "Adults|Evening Classes|Ballet Burn & Limbering",
                "Adults|Evening Classes|Jazz",
            ]
        )
    }
    
    func getClassDates(_ classDetails: Class) throws -> [DateInterval] {
        // TODO
        sleep(2)
        
        // Today at 8pm
        var baseDateComponents = Calendar.current.dateComponents([.calendar, .year, .month, .day], from: Date())
        baseDateComponents.hour = 20
        let baseDate = baseDateComponents.date
        
        let minute: TimeInterval = 60.0
        let hour: TimeInterval = 60.0 * minute
        let day: TimeInterval = 24 * hour
        
        // Create dates every 7 days
        let interval: TimeInterval = 7 * day
        
        return [
            DateInterval(start: baseDate!.addingTimeInterval(interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(2*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(3*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(4*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(5*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(6*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(7*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(8*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(9*interval), duration: hour),
            DateInterval(start: baseDate!.addingTimeInterval(10*interval), duration: hour)
        ]
    }
    
}
