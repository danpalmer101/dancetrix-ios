//
//  Configuration.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class Configuration {
    
    static func fromPaymentEmailAddress() -> String {
        return "Dance Trix Payments <payments@danpalmer101.io>"
    }
    
    static func fromBookingEmailAddress() -> String {
        return "Dance Trix Bookings <bookings@danpalmer101.io>"
    }
    
    static func fromUniformOrderEmailAddress() -> String {
        return "Dance Trix Uniforms <uniforms@danpalmer101.io>"
    }
    
    static func toEmailAddress() -> String {
        return "d.palmer101@googlemail.com"
    }
    
}
