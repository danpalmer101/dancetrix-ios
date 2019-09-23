//
//  EmailUniformService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 04/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import FirebaseStorage

class EmailUniformService: UniformServiceType {

    func getUniformOrderItems(successHandler: @escaping ([UniformGroup]) -> Void,
                              errorHandler: @escaping (Error) -> Void) {
        let csvName = "uniforms.csv"
        let classesMenuCsv = Storage.storage().reference().child(csvName)
        
        log.info("Retrieving uniforms...")
        
        log.debug("    Downloading CSV from Firebase storage: \(csvName)")
        
        DispatchQueue.main.async {
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            classesMenuCsv.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    log.warning(["...failed to retrieve uniforms", error])
                    errorHandler(error)
                } else if let data = data {
                    log.debug("    Downloaded CSV from Firebase storage: \(csvName)")
                    
                    if let csvString = data.asString() {
                        log.debug("    Parsing CSV: \(csvName)")
                        let uniforms = UniformParser.parse(csvString: csvString)
                        log.debug("    Parsed CSV: \(csvName)")
                        
                        log.info("...Retrieved uniforms")
                        
                        successHandler(uniforms)
                    } else {
                        errorHandler(OrderError.noUniforms)
                    }
                } else {
                    errorHandler(OrderError.noUniforms)
                }
            }
        }
    }
    
    func orderUniform(name: String,
                      studentName: String,
                      email: String,
                      package: String?,
                      paymentMade: Bool,
                      paymentMethod: String,
                      additionalInfo: String?,
                      orderItems: [UniformItem : String?],
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
                "orderItems": Dictionary(uniqueKeysWithValues: orderItems.map { (key, value) in return (key.name, value) }),
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
