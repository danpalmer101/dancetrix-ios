//
//  CalendarCell.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 28/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {

    @IBOutlet
    var dayLabel : UILabel!
    
    @IBOutlet
    var indicator: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.indicator.backgroundColor = Theme.colorTint
        self.indicator.layer.cornerRadius = min(self.indicator.frame.size.height, self.indicator.frame.size.width) / 2
    }
    
}
