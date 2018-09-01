//
//  MockUniformService.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

class MockUniformService: UniformServiceType {
    
    func getUniformOrderItems(successHandler: @escaping ([UniformGroup]) -> Void,
                              errorHandler: @escaping (Error) -> Void) {
        DispatchQueue.global().async {
            log.info("Mock uniform retrieval...")
            sleep(1)
            
            log.debug("    Generating uniform groups")
            
            if let path = Bundle.main.path(forResource: "uniforms", ofType: "csv") {
                let csvString = try! String(contentsOfFile: path)
                let uniforms = UniformParser.parse(csvString: csvString)
                
                log.info("...mock uniform retrieved")
                successHandler(uniforms)
            } else {
                log.warning("...Unable to load uniform")
                errorHandler(OrderError.noUniforms)
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
        DispatchQueue.global().async {
            log.info("Mock uniform order...")
            
            orderItems.forEach { (arg: (key: UniformItem, value: String?)) in
                let (key, size) = arg
                
                log.info("    \(key.name) - size: \(size ?? "N/A")")
            }
            
            sleep(2)
            
            log.info("...uniform order complete")
            
            successHandler()
        }
    }
    
}
