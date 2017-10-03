//
//  ServiceLocator.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ServiceLocator {
    
    static var classService: ClassServiceType = MockClassService()
    static var bookingService: BookingServiceType = EmailBookingService()
    static var paymentService: PaymentServiceType = EmailPaymentService()
    static var orderService: OrderServiceType = MockOrderService()
    static var emailService: EmailServiceType = MockEmailService()
    
}
