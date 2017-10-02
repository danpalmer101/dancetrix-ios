//
//  BookingServiceType.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol BookingServiceType {
    
    func bookClass(classDetails: Class,
                   dates: [DateInterval],
                   name: String,
                   email: String,
                   successHandler: @escaping () -> Void,
                   errorHandler: @escaping (Error) -> Void)
    
}
