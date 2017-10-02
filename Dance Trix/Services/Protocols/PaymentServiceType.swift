//
//  PaymentServiceType.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol PaymentServiceType {
    
    func notify(date: Date,
                amount: Double,
                name: String,
                studentName: String,
                email: String,
                method: String,
                reason: String,
                otherDetails: String?,
                successHandler: @escaping () -> Void,
                errorHandler: @escaping (Error) -> Void)
    
}
