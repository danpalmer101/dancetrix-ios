//
//  MockEmailService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import SendGrid

class MockEmailService : SendGridEmailService {
    
    override func send(email: Email,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        sleep(2)
        
        log.info("...mock email sent")
        
        successHandler()
    }
    
}
