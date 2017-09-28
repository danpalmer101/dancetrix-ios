//
//  CalendarViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 28/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController : UIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    var dates : [Date : Class]?
    
    @IBOutlet
    var calendarView: JTAppleCalendarView!
    
    // MARK: - JTAppleCalendarViewDelegate implementation
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        return calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "JTCalendarCell", for: indexPath)
    }
    
    // MARK: - JTAppleCalendarViewDataSource implementation
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: Date().addingTimeInterval(-60 * 60 * 60 * 365),
                                       endDate: Date().addingTimeInterval(60 * 60 * 24 * 365))
    }
    
}
