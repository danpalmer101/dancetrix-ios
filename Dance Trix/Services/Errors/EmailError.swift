//
//  EmailError.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 04/10/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

enum EmailError: Error {
    case unableToSend(message: String?)
}
