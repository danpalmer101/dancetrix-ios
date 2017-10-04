//
//  MockOrderService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockOrderService: OrderServiceType {
    
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
        DispatchQueue.global().async {
            log.info("Mock uniform order...")
            
            orderItems.forEach { (arg: (key: String, value: String?)) in
                let (key, size) = arg
                
                log.info(String(format: "    %@ - size: %@",
                                key,
                                size ?? "N/A"))
            }
            
            sleep(2)
            
            log.info("...uniform order complete")
            
            successHandler()
        }
    }
    
}
