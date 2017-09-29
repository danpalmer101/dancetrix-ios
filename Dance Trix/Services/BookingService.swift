//
//  BookingService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol BookingService {
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String, successHandler: () -> Void, errorHandler: (Error) -> Void)
}

class MockBookingService {
    
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String, successHandler: () -> Void, errorHandler: (Error) -> Void) {
        sleep(2)
        
        //errorHandler(BookingError.errorBooking(classDetails: classDetails, dates: dates))
        
        successHandler()
    }
    
}
