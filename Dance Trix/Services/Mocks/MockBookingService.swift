//
//  MockBookingService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockBookingService : BookingServiceType {
    
    func bookClass(classDetails: Class,
                   dates: [DateInterval],
                   name: String,
                   email: String,
                   successHandler: @escaping () -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock booking processing...")
            
            sleep(2)
            
            log.info("...booking processing complete")
            
            successHandler()
        }
    }
    
}
