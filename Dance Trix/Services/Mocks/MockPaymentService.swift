//
//  MockPaymentService
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockPaymentService: PaymentServiceType {
    
    func notify(date: Date,
                amount: Double,
                name: String,
                studentName: String,
                email: String,
                method: String,
                reason: String,
                otherDetails: String?,
                successHandler: @escaping () -> Void,
                errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock payment processing...")
            
            ServiceLocator.emailService.sendEmail(templateName: "test",
                                                  from: "payments@dancetrix.co.uk",
                                                  to: ["d.palmer101@googlemail.com"],
                                                  templateVariables: [:],
                                                  successHandler: {
                                                    log.info("...payment processing complete")
                                                    
                                                    successHandler()
                                                  },
                                                  errorHandler: {(e: Error) in
                                                    errorHandler(e)
                                                  })
        }
    }
    
}
