//
//  EmailPaymentService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class EmailPaymentService : PaymentServiceType {
    
    func notify(date: Date,
                amount: Double,
                name: String,
                studentName: String,
                email: String,
                method: String,
                reason: String,
                additionalInfo: String?,
                successHandler: @escaping () -> Void,
                errorHandler: @escaping (Error) -> Void) {
        log.info("Processing payment via email...")
        
        ServiceLocator.emailService.sendEmail(
            templateName: "payment_notify",
            from: Configuration.fromPaymentEmailAddress(),
            to: Configuration.toEmailAddress(),
            templateVariables: [
                "date": date,
                "amount": amount,
                "name": name,
                "studentName": studentName,
                "email": email,
                "method": method,
                "reason": reason,
                "additionalInfo": additionalInfo
            ],
            successHandler: {
                log.info("...payment processing complete")
                successHandler()
            },
            errorHandler: {(e: Error) in
                errorHandler(e)
            })
    }
    
}
