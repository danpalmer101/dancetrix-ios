//
//  TitleNavigationItem.swift
//  Dance Trix
//
//  Created by Daniel Palmer on 23/09/2017.
//  Copyright © 2017 Dance Trix. All rights reserved.
//

import UIKit

class TitleNavigationItem: UINavigationItem {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let titleView = UIImageView(image: UIImage(named: "Logo Navigation"))
        titleView.contentMode = .scaleAspectFit
        
        self.titleView = titleView
    }
    
}
