//
//  ClassServiceType.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 02/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

protocol ClassServiceType {
    
    func getClassMenu(successHandler: @escaping (ClassMenu) -> Void,
                      errorHandler: @escaping (Error) -> Void)
    
    func getClassDates(_ classDetails: Class,
                       successHandler: @escaping ([DateInterval]) -> Void,
                       errorHandler: @escaping (Error) -> Void)
    
    func getClassDescription(_ classDetails: Class,
                             successHandler: @escaping (String) -> Void,
                             errorHandler: @escaping (Error) -> Void)
    
    func getImportantDates(successHandler: @escaping ([(String, DateInterval)]) -> Void,
                           errorHandler: @escaping (Error) -> Void)
}
