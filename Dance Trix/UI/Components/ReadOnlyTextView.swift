//
//  ReadOnlyTextView.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 25/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class ReadOnlyTextView: UITextView {

    let fadePercentage = CGFloat(0.2)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.isEditable = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let transparent = UIColor.clear.cgColor
        let opaque = Theme.colorBackground.cgColor
        
        let maskLayer = CALayer()
        maskLayer.frame = self.bounds
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: self.bounds.origin.x,
                                     y: 0,
                                     width: self.bounds.size.width,
                                     height: self.bounds.size.height)
        gradientLayer.colors = [transparent, opaque, opaque, transparent]
        gradientLayer.locations = [0, 0.2, 0.8, 1]
        
        maskLayer.addSublayer(gradientLayer)
        self.layer.mask = maskLayer
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
    
}
