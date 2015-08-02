//
//  PeriodButton.swift
//  TimeIt
//
//  Created by knut on 14/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//
import Foundation
import UIKit

class PeriodButton:UIButton {
    
    var period:Period!
    var childButtons:[PeriodButton]!
    var level:Int!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, level:Int) {
        super.init(frame: frame)
        
        self.titleLabel!.numberOfLines = 1
        self.titleLabel!.adjustsFontSizeToFitWidth = true
        self.titleLabel?.lineBreakMode = NSLineBreakMode.ByClipping
        
        self.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2.0;
        self.level = level
    }
   
    func setPeriodAndTitle(periodParam:Period)
    {
        self.period = periodParam
        var title = period.formattedTime //"\(period.fromYear)-\(period.toYear)"
        self.setTitle(title, forState: UIControlState.Normal)
    }

}