//
//  TextField.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 26/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class TextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.borderWidth = 2
        self.layer.borderColor = Theme.colorTint.cgColor
        self.layer.cornerRadius = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if (self.placeholder != nil) {
            var attributes = [NSAttributedStringKey: Any]();
            attributes[.foregroundColor] = Theme.colorForegroundDark
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder!, attributes: attributes)
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return internalRect(bounds)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return internalRect(bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return internalRect(bounds)
    }
    
    private func internalRect(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10,
                      y: bounds.origin.y,
                      width: bounds.size.width - 20,
                      height: bounds.size.height)
    }
    
}
