//
//  MockOrderService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockOrderService: OrderServiceType {
    
    func order(name: String,
               student: String,
               email: String,
               package: String?,
               paymentMade: Bool,
               paymentMethod: String,
               additionalInfo: String?,
               orderItems: [String : (Bool, String?)],
               successHandler: @escaping () -> Void,
               errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock order processing...")
            
            orderItems.forEach { (arg: (key: String, value: (Bool, String?))) in
                let (key, (ordered, size)) = arg
                
                log.info(String(format: "   %@ - ordered: %@, size: %@",
                                key,
                                ordered ? "true" : "false",
                                size ?? "N/A"))
            }
            
            sleep(2)
            
            log.info("...order processing complete")
            
            successHandler()
        }
    }
    
}
