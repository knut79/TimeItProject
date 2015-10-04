//
//  TimelineEventLabel.swift
//  TimeIt
//
//  Created by knut on 30/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import UIKit

class TimelineEventLabel: UILabel {
    
    var event:HistoricEvent!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    init(frame: CGRect, event:HistoricEvent) {
        super.init(frame: frame)
        
        
        let string = "\(event.title)\n"
        self.text = string
        self.textAlignment = NSTextAlignment.Center
        self.numberOfLines = 1
        self.adjustsFontSizeToFitWidth = true
        self.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.textColor = UIColor.grayColor()
        self.userInteractionEnabled = true
        
        self.event = event

    }
    
}