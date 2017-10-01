//
//  ServiceLocator.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class ServiceLocator {
    
    static var classService: ClassService = MockClassService()
    static var bookingService: BookingService = MockBookingService()
    static var paymentService: PaymentService = MockPaymentService()
    
}
