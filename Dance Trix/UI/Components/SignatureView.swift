//
//  SignatureView.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 24/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class SignatureView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.size.height / 12.0
        self.layer.borderColor = Theme.colorTint.cgColor
        self.layer.borderWidth = 1
    }
    
}
