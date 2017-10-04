//
//  MockEmailService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation
import SwiftMailgun

class MockEmailService : MailgunEmailService {
    
    override func send(email: MailgunEmail,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        
        log.debug("Subject: " + (email.subject ?? ""))
        log.debug("Content:")
        log.debug("======= html =======")
        log.debug(email.html ?? "<null>")
        log.debug("======= text =======")
        log.debug(email.text ?? "<null>")
        
        sleep(2)
        
        log.info("...mock email sent")
        
        successHandler()
    }
    
}
