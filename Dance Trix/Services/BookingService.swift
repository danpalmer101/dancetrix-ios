//
//  BookingService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol BookingService {
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String) throws
}

class MockBookingService {
    
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String) throws {
        // TODO
        sleep(2)
    }
    
}
