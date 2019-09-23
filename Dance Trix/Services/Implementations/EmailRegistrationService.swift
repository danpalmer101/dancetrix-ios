//
//  EmailRegistrationService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 14/02/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation
import FirebaseStorage

class EmailRegistrationService : RegistrationServiceType {
    
    func registerAdult(registration: RegistrationAdult,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        uploadImage(registration.signature,
                    successHandler: { (signatureUrl) in
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
                                "phone": registration.phone,
                                "signatureUrl": signatureUrl?.absoluteString
                            ],
                            successHandler: {
                                log.info("...adult registration complete")
                                successHandler()
                            },
                            errorHandler: {(e: Error) in
                                errorHandler(e)
                            })
                        },
                        errorHandler: { (error) in
                            errorHandler(error ?? EmailError.unableToSend(message: "Unable to upload signature"))
                        })
    }
    
    func registerChild(registration: RegistrationChild,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        
        uploadImage(registration.signature,
                    successHandler: { (signatureUrl) in
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
                                "photoConsent": registration.consent,
                                "signatureUrl": signatureUrl?.absoluteString
                            ],
                            successHandler: {
                                log.info("...child registration complete")
                                successHandler()
                        },
                            errorHandler: {(e: Error) in
                                errorHandler(e)
                        })
                    },
                    errorHandler: { (error) in
                        errorHandler(error ?? EmailError.unableToSend(message: "Unable to upload signature"))
                    })
    }
    
    private func uploadImage(_ image: UIImage?,
                             successHandler: @escaping (URL?) -> Void,
                             errorHandler: @escaping (Error?) -> Void) {
        guard let image = image else {
            // Treat no image as a positive outcome
            successHandler(nil)
            return
        }
        
        guard let inverseImage = image.inverseImage(cgResult: true),
              let data = inverseImage.pngData() else {
            // Invalid image is a negative outcome
            errorHandler(nil)
            return
        }
        
        let imageReference = Storage.storage().reference()
            .child("signatures/\(UUID.init().uuidString).png")
        
        DispatchQueue.main.async {
            imageReference.putData(data, metadata: nil) { (_, error) in
                if let error = error {
                    errorHandler(error)
                    return
                }
                
                imageReference.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        errorHandler(error)
                        return
                    }
                    
                    successHandler(downloadURL)
                }
            }
        }
    }
}
