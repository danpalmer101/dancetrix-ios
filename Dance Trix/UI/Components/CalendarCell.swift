//
//  CalendarCell.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 28/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTACDayCell {

    @IBOutlet
    var dayLabel : UILabel!
    
    @IBOutlet
    var classIndicator: UIView!
    
    @IBOutlet
    var importantIndicator: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.classIndicator.backgroundColor = Theme.colorForeground
        self.classIndicator.layer.cornerRadius = min(self.classIndicator.frame.size.height, self.classIndicator.frame.size.width) / 2
        
        self.importantIndicator.backgroundColor = Theme.colorTint
        self.importantIndicator.layer.cornerRadius = min(self.importantIndicator.frame.size.height, self.importantIndicator.frame.size.width) / 2
    }
    
}
