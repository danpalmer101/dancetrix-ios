//
//  EmailServiceType.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 03/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol EmailServiceType {
    
    func sendEmail(templateName: String,
                   from: String,
                   to: [String],
                   templateVariables: [String : Any?],
                   successHandler: @escaping () -> Void,
                   errorHandler: @escaping (Error) -> Void)
    
}
