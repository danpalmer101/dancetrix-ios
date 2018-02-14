//
//  MockRegistrationService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 14/02/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation

class MockRegistrationService : RegistrationServiceType {
    
    func registerAdult(registration: RegistrationAdult,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock registration processing...")
            
            sleep(2)
            
            log.info("...registration processing complete")
            
            successHandler()
        }
    }
    
    func registerChild(registration: RegistrationChild,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock registration processing...")
            
            sleep(2)
            
            log.info("...registration processing complete")
            
            successHandler()
        }
    }
    
}
