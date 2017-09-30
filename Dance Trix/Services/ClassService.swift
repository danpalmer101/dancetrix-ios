//
//  ClassServices.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol ClassService {
    func getClassMenu(successHandler: (ClassMenu) -> Void, errorHandler: (Error) -> Void)
    func getClassDates(_ classDetails: Class, successHandler: ([DateInterval]) -> Void, errorHandler: (Error) -> Void)
}

class MockClassService {
    
    var classMenuCache: ClassMenu?
    var datesCache = [Class : [DateInterval]]()
    
    func getClassMenu(successHandler: @escaping (ClassMenu) -> Void, errorHandler: (Error) -> Void) {
        if (self.classMenuCache == nil) {
            //sleep(2)
            
            self.classMenuCache = ClassMenuParser.parse(
                serviceNames: [
                    "Children|Autumn Half Term 1 2017|Children's Saturday Classes",
                    "Children|Autumn Half Term 2 2017|Children's Saturday Classes",
                    "Children|Spring Half Term 1 2018|Children's Saturday Classes",
                    "Children|Spring Half Term 2 2018|Children's Saturday Classes",
                    "Children|Summer Half Term 1 2018|Children's Saturday Classes",
                    "Children|Summer Half Term 2 2018|Children's Saturday Classes",
                    "Children|Autumn Half Term 1 2017|Tiny Trixies",
                    "Children|Autumn Half Term 2 2017|Tiny Trixies",
                    "Children|Spring Half Term 1 2018|Tiny Trixies",
                    "Children|Spring Half Term 2 2018|Tiny Trixies",
                    "Children|Summer Half Term 1 2018|Tiny Trixies",
                    "Children|Summer Half Term 2 2018|Tiny Trixies",
                    "Adults|Day Time Classes|Ballet & Tap",
                    "Adults|Day Time Classes|Mummy Ballet Burn",
                    "Adults|Evening Classes|Advanced Tap",
                    "Adults|Evening Classes|Advanced Ballet",
                    "Adults|Evening Classes|Beginner/Intermediate Ballet",
                    "Adults|Evening Classes|Intermediate Tap",
                    "Adults|Evening Classes|Beginners Tap",
                    "Adults|Evening Classes|Ballet Burn & Limbering",
                    "Adults|Evening Classes|Jazz",
                ]
            )
        }
        
        DispatchQueue.global().async {
            //errorHandler(ClassesError.errorRetrievingClasses)
            successHandler(self.classMenuCache!)
        }
    }
    
    func getClassDates(_ classDetails: Class, successHandler: @escaping ([DateInterval]) -> Void, errorHandler: (Error) -> Void) {
        if (datesCache[classDetails] == nil) {
            //sleep(2)
            
            let minute: TimeInterval = 60.0
            let hour: TimeInterval = 60.0 * minute
            let day: TimeInterval = 24 * hour
            
            // Create dates every 7 days
            let interval: TimeInterval = 7 * day
            
            // First class is random time (9am - 8pm) on random day within the next 7 days
            var baseDateComponents = Calendar.current.dateComponents([.calendar, .year, .month, .day], from: Date())
            baseDateComponents.hour = Int(arc4random_uniform(11) + 9)
            let baseDate = baseDateComponents.date?.addingTimeInterval(day * 3 * Double(arc4random_uniform(3)))
            
            var dates = [DateInterval]()
            
            for i in 0...9 {
                dates.append(DateInterval(start: baseDate!.addingTimeInterval(Double(i) * interval), duration: hour))
            }
            
            datesCache[classDetails] = dates
        }
        
        DispatchQueue.global().async {
            //errorHandler(ClassesError.errorRetrivingClassDates(classDetails: classDetails))
            successHandler(self.datesCache[classDetails]!)
        }
    }
    
}
