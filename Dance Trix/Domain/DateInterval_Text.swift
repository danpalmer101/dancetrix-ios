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
        if let time = asTimeOnlyText() {
            return "\(asDateOnlyText()) (\(time))"
        } else {
            return asDateOnlyText()
        }
    }
    
    func asDateOnlyText() -> String {
        return "\(dateText(date: start))"
    }
    
    func asTimeOnlyText() -> String? {
        if (duration > 0) {
            return "\(timeText(date: start)) to \(timeText(date: end))"
        } else {
            return nil
        }
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
