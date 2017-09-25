//
//  ReadOnlyTextView.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 25/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class ReadOnlyTextView: UITextView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.isEditable = false
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
}
