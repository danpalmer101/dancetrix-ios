//
//  Class.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 22/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class Class : Hashable, Equatable {
    
    //MARK: Properties
    
    var id: String
    var path: String
    var name: String
    var datesLocation: String
    var descriptionLocation: String
    var allowIndividualBookings: Bool
    
    //MARK: Initialization
    
    init?(id: String,
          path: String,
          name: String,
          datesLocation: String,
          descriptionLocation: String,
          allowIndividualBookings: Bool) {
        self.id = id
        self.path = path
        self.name = name
        self.datesLocation = datesLocation
        self.descriptionLocation = descriptionLocation
        self.allowIndividualBookings = allowIndividualBookings
    }
    
    //MARK: Equatable
    
    static func ==(lhs: Class, rhs: Class) -> Bool {
        return lhs.id == rhs.id
    }
    
    //MARK: Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}
