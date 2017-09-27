//
//  ClassesError.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 27/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import Foundation

enum ClassesError: Error {
    case noClasses
    case errorRetrievingClasses
    case noClassDates(classDetails: Class)
    case errorRetrivingClassDates(classDetails: Class)
}
