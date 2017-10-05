//
//  EmailOrderService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 04/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class EmailOrderService: OrderServiceType {

    func getUniformOrderItems() -> [(String, [(String, String, [String])])] {
        return MockOrderService().getUniformOrderItems()
    }
    
    func orderUniform(name: String,
                      studentName: String,
                      email: String,
                      package: String?,
                      paymentMade: Bool,
                      paymentMethod: String,
                      additionalInfo: String?,
                      orderItems: [String : String?],
                      successHandler: @escaping () -> Void,
                      errorHandler: @escaping (Error) -> Void) {
        log.info("Placing uniform order via email...")
        
        ServiceLocator.emailService.sendEmail(
            templateName: "uniform_order",
            from: Configuration.fromUniformOrderEmailAddress(),
            to: Configuration.toEmailAddress(),
            templateVariables: [
                "name": name,
                "studentName": studentName,
                "email": email,
                "package": package,
                "paymentMade": paymentMade,
                "paymentMethod": paymentMethod,
                "orderItems": orderItems,
                "additionalInfo": additionalInfo
            ],
            successHandler: {
                log.info("...uniform order complete")
                successHandler()
        },
            errorHandler: {(e: Error) in
                errorHandler(e)
        })
    }
    
}
