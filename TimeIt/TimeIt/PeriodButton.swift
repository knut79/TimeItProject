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
    var insideLabel:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, level:Int, period:Period) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
        
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 2.0;
        self.level = level

        
        /*
        if periodButton.frame.size.width < (UIScreen.mainScreen().bounds.size.width / 4)
        {
        periodButton.titleLabel?.font = UIFont.systemFontOfSize(10)
        }
        if buttonHeight < CGFloat(70)
        {
        periodButton.enabled = false
        periodButton.backgroundColor = UIColor.lightGrayColor()
        }
        */
        

        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

        self.period = period
        let title = period.formattedTime //"\(period.fromYear)-\(period.toYear)"

        
        let margin:CGFloat = 5
        insideLabel = UILabel(frame: CGRectMake(margin, margin, frame.width - (margin * 2), frame.height - (margin * 2)))
        insideLabel.text = title
        insideLabel.numberOfLines = 1
        insideLabel.adjustsFontSizeToFitWidth = true
        insideLabel.lineBreakMode = NSLineBreakMode.ByClipping
        insideLabel.textAlignment = NSTextAlignment.Center
        insideLabel.backgroundColor = self.backgroundColor?.colorWithAlphaComponent(0)
        self.addSubview(insideLabel)

    }
   
    func setPeriodAndTitle(periodParam:Period)
    {
        self.period = periodParam
        let title = period.formattedTime //"\(period.fromYear)-\(period.toYear)"
        insideLabel.text = title
    }

}