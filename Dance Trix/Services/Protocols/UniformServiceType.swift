//
//  UniformServiceType.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol UniformServiceType {
    
    func getUniformOrderItems() -> [UniformGroup];
    
    func orderUniform(name: String,
                      studentName: String,
                      email: String,
                      package: String?,
                      paymentMade: Bool,
                      paymentMethod: String,
                      additionalInfo: String?,
                      orderItems: [UniformItem : String?],
                      successHandler: @escaping () -> Void,
                      errorHandler: @escaping (Error) -> Void)
    
}
