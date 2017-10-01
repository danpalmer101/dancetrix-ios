//
//  BookingService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol BookingService {
    
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String, successHandler: @escaping () -> Void, errorHandler: @escaping (Error) -> Void)
    
}

class MockBookingService : BookingService {
    
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String, successHandler: @escaping () -> Void, errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            
            //errorHandler(BookingError.errorBooking(classDetails: classDetails, dates: dates))
            successHandler()
        }
    }
    
}
