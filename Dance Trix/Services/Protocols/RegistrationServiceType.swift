//
//  RegistrationServiceType.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 14/02/2018.
//  Copyright © 2018 Dance Trix. All rights reserved.
//

import Foundation

protocol RegistrationServiceType {
    
    func registerAdult(registration: RegistrationAdult,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void)
    
    func registerChild(registration: RegistrationChild,
                       successHandler: @escaping () -> Void,
                       errorHandler: @escaping (Error) -> Void)
    
}
