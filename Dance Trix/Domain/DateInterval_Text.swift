//
//  DateInterval_Text.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 24/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

extension DateInterval {
    
    func asText() -> String {
        return "\(dateText(date: start)) (\(asTimeOnlyText()))"
    }
    
    func asTimeOnlyText() -> String {
        return "\(timeText(date: start)) to \(timeText(date: end))"
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
