//
//  SubmitButton.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 24/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class SubmitButton: UIButton {
    
    var activityIndicator : UIActivityIndicatorView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = self.frame.size.height / 4.0
    }
    
    init?(parentView: UIView, title: String) {
        super.init(frame: CGRect(x: 16, y: 16, width: parentView.frame.size.width - 32, height: parentView.frame.size.height - 32))
        
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = self.frame.size.height / 4.0
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.setTitleColor(Theme.colorForeground, for: .normal)
        self.setTitleColor(Theme.colorForeground.withAlphaComponent(0.5), for: .selected)
        self.setTitleColor(Theme.colorForeground.withAlphaComponent(0.5), for: .highlighted)
        self.setTitleColor(Theme.colorForeground.withAlphaComponent(0.5), for: .disabled)
    }
    
    func overlayActivityIndicator() {
        self.activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        let width = self.activityIndicator!.frame.size.width
        let height = self.activityIndicator!.frame.size.height
        let buttonFrame = self.frame
        self.activityIndicator!.frame = CGRect(
            x: buttonFrame.origin.x + ((buttonFrame.size.width - width) / 2),
            y: buttonFrame.origin.y + ((buttonFrame.size.height - height) / 2),
            width: width,
            height: height)
        
        self.superview?.insertSubview(activityIndicator!, aboveSubview: self)
    }
    
}
