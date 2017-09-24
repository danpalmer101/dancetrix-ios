//
//  DateRange.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 24/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class DateRange {
    
    var startDate: Date
    var endDate: Date
    
    //MARK: Initialization
    
    init?(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    //MARK: Accessors
    
    func asText() -> String {
        return "\(dateText(date: startDate)) (\(timeText(date: startDate)) to \(timeText(date: endDate)))"
    }
    
    private func dateText(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from:date as Date)
    }
    
    private func timeText(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from:date as Date)
    }
    
}
