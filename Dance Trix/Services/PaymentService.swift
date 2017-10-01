//
//  PaymentService
//  Dance Trix
//
//  Created by Daniel Palmer on 01/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol PaymentService {

    func notify(date: Date, amount: Double, name: String, studentName: String, method: String, reason: String, otherDetails: String?, successHandler: @escaping () -> Void, errorHandler: @escaping (Error) -> Void)
    
}

class MockPaymentService: PaymentService {
    
    func notify(date: Date, amount: Double, name: String, studentName: String, method: String, reason: String, otherDetails: String?, successHandler: @escaping () -> Void, errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            sleep(2)
            
            successHandler()
        }
    }
    
}
