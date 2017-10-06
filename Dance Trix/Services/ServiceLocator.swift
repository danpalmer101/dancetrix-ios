//
//  ServiceLocator.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ServiceLocator {
    
    // Quickly switch between fully mocked and real services
    static let mock = true
    static let mockEmail = true
    
    static let classService: ClassServiceType = mock ? MockClassService() : FirebaseStorageClassService()
    static let bookingService: BookingServiceType = mock ? MockBookingService() : EmailBookingService()
    static let paymentService: PaymentServiceType = mock ? MockPaymentService() : EmailPaymentService()
    static let orderService: OrderServiceType = mock ? MockOrderService() : EmailOrderService()
    static let emailService: EmailServiceType = mockEmail ? MockEmailService() : MailgunEmailService()

}
