//
//  BookingService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class BookingService {
    
    func bookClass(classDetails: Class, dates: [DateInterval], name: String, email: String) throws {
        
        throw BookingError.errorBooking(classDetails: classDetails, dates: dates)
        // TODO
        sleep(2)
    }
    
}
