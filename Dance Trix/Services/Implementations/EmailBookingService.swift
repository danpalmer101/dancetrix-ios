//
//  EmailBookingService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class EmailBookingService : BookingServiceType {
    
    func bookClass(classDetails: Class,
                   dates: [DateInterval],
                   name: String,
                   email: String,
                   successHandler: @escaping () -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        log.info("Booking class via email...")
        
        ServiceLocator.emailService.sendEmail(
            templateName: "class_booking",
            from: Configuration.fromBookingEmailAddress(),
            to: [Configuration.toEmailAddress()],
            templateVariables: [
                "class": classDetails.name,
                "dates": dates.map({ d -> Date in d.start }),
                "name": name,
                "email": email
            ],
            successHandler: {
                log.info("...booking complete")
                successHandler()
            },
            errorHandler: {(e: Error) in
                errorHandler(e)
            })
    }
    
}
