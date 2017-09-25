//
//  TintImageView.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 23/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class TintImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
    }
    
}
