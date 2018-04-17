//
//  CalendarViewController.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 28/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import JTAppleCalendar
import Firebase

class CalendarViewController : AnalyticsUIViewController, JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    private var classDates = [Date : [(classDetails: Class, date: DateInterval)]]()
    private var importantDates = [Date : [(String, DateInterval)]]()
    
    private var datesErrorDisplayed = false
    
    @IBOutlet
    var calendarView: JTAppleCalendarView!
    @IBOutlet
    var tableView: UITableView!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateTitle()
        
        self.loadClassDates()
        self.loadImportantDates()
    }
    
    private func loadClassDates() {
        self.datesErrorDisplayed = false
        
        DispatchQueue.global().async {
            ServiceLocator.classService.getClassMenu(
                successHandler: { (classMenu: ClassMenu) in
                    self.addDates(classMenu)
                },
                errorHandler: { (error: Error) in
                    switch error {
                    case ClassesError.noClasses:
                        log.warning("No classes found")
                        
                        Notification.show(
                            title: "Sorry!",
                            subtitle: "There aren't any dance classes that can be booked at the moment.",
                            type: NotificationType.warning)
                        
                        break
                    default:
                        log.error(["An unexpected error occurred loading classes", error])
                        
                        Notification.show(
                            title: "Error",
                            subtitle: "An unexpected error occurred loading our dance classes, please try again later.",
                            type: NotificationType.error)
                    }
                }
            )
        }
    }
    
    private func addDates(_ classMenu: ClassMenu) {
        if let classDetails = classMenu.classDetails {
            ServiceLocator.classService.getClassDates(
                classDetails,
                successHandler: { (dates: [DateInterval]) in
                    DispatchQueue.main.async {
                        // Add each date to the map
                        dates.forEach({
                            (date: DateInterval) in self.addDate((classDetails, date))
                        })
                    
                        // Reload the calendar with the new date
                        // (and ensure current selected dates remain selected after reload)
                        let selectedDates = self.calendarView.selectedDates
                        self.calendarView.reloadData(
                            withanchor: self.calendarView.selectedDates.first,
                            completionHandler: {
                                self.tableView.reloadData()
                                self.calendarView.selectDates(selectedDates)
                            }
                        )
                    }
                },
                errorHandler: { (error: Error) in
                    switch error {
                    case ClassesError.noClassDates:
                        // No message to user if no dates found
                        log.warning(["No class dates found", classDetails])
                        break
                    default:
                        log.error(["An unexpected error occurred loading class dates", error])
                        
                        if (!self.datesErrorDisplayed) {
                            self.datesErrorDisplayed = true
                            
                            Notification.show(
                                title: "Warning",
                                subtitle: "An unexpected error occurred loading dates for some of our classes, some classes will be missing from the calendar.",
                                type: NotificationType.warning)
                        }
                    }
                }
            )
        }
        
        // Add the children recursively
        classMenu.children?.forEach({
            (child : ClassMenu) in self.addDates(child)
        })
    }
    
    private func addDate(_ classDate: (classDetails: Class, date: DateInterval)) {
        // Append this class/date tuple to the map, with the key as the start of day
        let startOfDay = Calendar.current.startOfDay(for: classDate.date.start)
        
        var existingDate = self.classDates[startOfDay]
        if (existingDate == nil) {
            self.classDates[startOfDay] = [classDate]
        } else {
            existingDate!.append((classDate.classDetails, classDate.date))
            self.classDates[startOfDay] = existingDate?.sorted(by: {
                (a: (_: Class, date: DateInterval), b: (_: Class, date: DateInterval)) -> Bool in
                    return a.date.start < b.date.start
                })
        }
    }
    
    private func loadImportantDates() {
        ServiceLocator.classService.getImportantDates(
            successHandler: { (dates: [(String, DateInterval)]) in
                DispatchQueue.main.async {
                    // Add each date to the map
                    dates.forEach({
                        (date: (String, DateInterval)) in
                            // Append this class/date tuple to the map, with the key as the start of day
                            let startOfDay = Calendar.current.startOfDay(for: date.1.start)
                            
                            var existingDate = self.importantDates[startOfDay]
                            if (existingDate == nil) {
                                self.importantDates[startOfDay] = [date]
                            } else {
                                existingDate!.append(date)
                                self.importantDates[startOfDay] = existingDate?.sorted(by: {
                                    (a: (_: String, date: DateInterval), b: (_: String, date: DateInterval)) -> Bool in
                                    return a.date.start < b.date.start
                                })
                            }
                    })
                    
                    // Reload the calendar with the new date
                    // (and ensure current selected dates remain selected after reload)
                    let selectedDates = self.calendarView.selectedDates
                    self.calendarView.reloadData(
                        withanchor: self.calendarView.selectedDates.first,
                        completionHandler: {
                            self.tableView.reloadData()
                            self.calendarView.selectDates(selectedDates)
                    }
                    )
                }
            },
            errorHandler: { (error: Error) in
                switch error {
                case ClassesError.noImportantDates:
                    // No message to user if no dates found
                    log.warning("No important dates found")
                    break
                default:
                    log.error(["An unexpected error occurred loading important dates", error])
                }
            }
        )
    }
    
    // MARK: - JTAppleCalendarViewDelegate implementation
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let calendarCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! CalendarCell
        
        // Default style
        calendarCell.backgroundColor = UIColor.clear
        calendarCell.dayLabel.textColor = Theme.colorForeground
        calendarCell.dayLabel.font = UIFont.systemFont(ofSize: 15)
        calendarCell.layer.cornerRadius = 5
        calendarCell.layer.borderWidth = 0 // Hidden border
        calendarCell.layer.borderColor = Theme.colorTint.cgColor
        
        // Previous/next month dates
        if (cellState.dateBelongsTo != .thisMonth) {
            calendarCell.dayLabel.textColor = Theme.colorForegroundMid
        }
        
        let today = Calendar.current.startOfDay(for: Date())
        
        if (date < today) {
            // Past - darken
            calendarCell.dayLabel.textColor = Theme.colorForegroundDark
        } else if (date == today) {
            // Present - default
        } else if (date > today) {
            // Future - default
        }
        
        // Date
        calendarCell.dayLabel.text = String(Calendar.current.component(.day, from: date))
        
        // Data indicators
        calendarCell.classIndicator.isHidden = self.classDates[date] == nil
        calendarCell.importantIndicator.isHidden = self.importantDates[date] == nil
        
        return calendarCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        // Allow selecting of today or future in current month
        return cellState.dateBelongsTo == .thisMonth && date >= Calendar.current.startOfDay(for: Date())
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        cell?.layer.borderWidth = 1 // Show border
        
        self.tableView.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        cell?.layer.borderWidth = 0 // Hide border
        
        self.tableView.reloadData()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.updateTitle()
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    // MARK: - JTAppleCalendarViewDataSource implementation
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        return ConfigurationParameters(startDate: Date(),
                                       endDate: Date().addingTimeInterval(60 * 60 * 24 * 365), // 1 year
                                       firstDayOfWeek: .monday)
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedImportantDates()?.count ?? 0) + (selectedClassDates()?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allSelectedImportantDates = selectedImportantDates()
        
        var cell : UITableViewCell
        
        // First indexes will be important dates, last indexes will be classes
        if (indexPath.row < allSelectedImportantDates?.count ?? 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: "ImportantCalendarEntry", for: indexPath)
            
            let selectedImportantDate = allSelectedImportantDates![indexPath.row]
            
            cell.textLabel?.textColor = Theme.colorTint
            cell.textLabel?.text = selectedImportantDate.desc
            cell.detailTextLabel?.text = selectedImportantDate.date.asTimeOnlyText()
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "ClassCalendarEntry", for: indexPath)
            
            let selectedClassDate = selectedClassDates()![indexPath.row - (allSelectedImportantDates?.count ?? 0)]
        
            cell.textLabel?.textColor = Theme.colorForeground
            cell.textLabel?.text = selectedClassDate.classDetails.name
            cell.detailTextLabel?.text = selectedClassDate.date.asTimeOnlyText()
        }
        return cell
    }
    
    private func selectedClassDates() -> [(classDetails: Class, date: DateInterval)]? {
        if let selectedDate = self.calendarView.selectedDates.first {
            return self.classDates[Calendar.current.startOfDay(for: selectedDate)]
        } else {
            return nil
        }
    }
    private func selectedImportantDates() -> [(desc: String, date: DateInterval)]? {
        if let selectedDate = self.calendarView.selectedDates.first {
            return self.importantDates[Calendar.current.startOfDay(for: selectedDate)]
        } else {
            return nil
        }
    }
    
    // MARK: - Actions
    
    private func updateTitle() {
        let visibleDate = self.calendarView.visibleDates().monthDates.first?.date ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        self.title = dateFormatter.string(from:visibleDate)
    }
    
}
