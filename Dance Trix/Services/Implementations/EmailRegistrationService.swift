//
//  EmailRegistrationService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 14/02/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation

class EmailRegistrationService : RegistrationServiceType {
    
    func registerAdult(registration: RegistrationAdult,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        log.info("Registering adult via email...")
        
        ServiceLocator.emailService.sendEmail(
            templateName: "registration_adult",
            from: Configuration.fromRegistrationEmailAddress(),
            to: Configuration.toEmailAddress(),
            templateVariables: [
                "address": registration.address,
                "dateOfBirth": registration.dateOfBirth,
                "email": registration.email,
                "emergencyName": registration.emergencyName,
                "emergencyPhone": registration.emergencyPhone,
                "experience": registration.experience,
                "medical": registration.medical,
                "name": registration.studentName,
                "phone": registration.phone
            ],
            successHandler: {
                log.info("...adult registration complete")
                successHandler()
            },
            errorHandler: {(e: Error) in
                errorHandler(e)
            })
    }
    
    func registerChild(registration: RegistrationChild,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        log.info("Registering child via email...")
        
        ServiceLocator.emailService.sendEmail(
            templateName: "registration_child",
            from: Configuration.fromRegistrationEmailAddress(),
            to: Configuration.toEmailAddress(),
            templateVariables: [
                "address": registration.address,
                "contact": registration.contact,
                "dateJoined": registration.dateJoined,
                "dateOfBirth": registration.dateOfBirth,
                "email": registration.email,
                "experience": registration.experience,
                "hearAbout": registration.hearAbout,
                "medical": registration.medical,
                "name": registration.name,
                "phone": registration.phone,
                "studentName": registration.studentName,
                "photoConsent": registration.consent
            ],
            successHandler: {
                log.info("...child registration complete")
                successHandler()
        },
            errorHandler: {(e: Error) in
                errorHandler(e)
        })
    }
    
}
