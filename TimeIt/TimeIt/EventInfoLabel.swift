//
//  EventInfoLabel.swift
//  TimeIt
//
//  Created by knut on 01/08/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import UIKit

class EventInfoLabel: UIView {
    
    var badgeLabelsNum:Int = 0
    var badgeLabels:[UILabel] = []
    var titleLabel:UILabel!
    var timeLabel:UILabel!
    var infoIcon:UILabel!
    var infoTextView:UIView!
    var infoText:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor() //.colorWithAlphaComponent(1)
        self.layer.borderColor = UIColor.grayColor().CGColor
        self.layer.borderWidth = 1
        
        titleLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height/2))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(titleLabel)

        timeLabel = UILabel(frame: CGRectMake(0, titleLabel.frame.maxY, frame.width, frame.height / 2))
        timeLabel.textColor = UIColor.blackColor()
        timeLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(timeLabel)
        
        infoIcon = UILabel(frame: CGRectMake(0, 0, self.bounds.height / 4, self.bounds.height / 4))
        infoIcon.textAlignment = NSTextAlignment.Center
        infoIcon.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
        infoIcon.text = "ℹ️"
        infoIcon.userInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapInfo")
        tapGesture.numberOfTapsRequired = 1
        infoIcon.addGestureRecognizer(tapGesture)
        infoIcon.alpha = 0
        self.addSubview(infoIcon)
        
        infoTextView = UIView(frame: CGRectZero)
        infoText = UILabel(frame: CGRectZero)
        infoText.textColor = UIColor.blackColor()
        infoText.textAlignment = NSTextAlignment.Center
        infoText.numberOfLines = 0
        infoText.adjustsFontSizeToFitWidth = true
        infoText.lineBreakMode = .ByWordWrapping
        infoTextView.layer.borderColor = UIColor.grayColor().CGColor
        infoTextView.layer.borderWidth = 1
        infoTextView.backgroundColor = UIColor.whiteColor()
        infoText.backgroundColor = infoTextView.backgroundColor
        infoText.alpha = 1
        infoTextView.addSubview(infoText)
        infoTextView.alpha = 0
        self.addSubview(infoTextView)
    }
    
    
    func setText(event:HistoricEvent)
    {
        self.infoTextView.alpha = 0
        timeLabel.text = event.formattedTime
        titleLabel.text = event.title
        infoText.text = event.text
        
        infoIcon.alpha = event.text != "" ? 1 : 0

        
        for item in badgeLabels
        {
            item.removeFromSuperview()
        }
        badgeLabels = []
        
        badgeLabelsNum = Int(event.loveScore)
        
        let badgeWidth = self.bounds.height / 4
        let badgeHeight = badgeWidth
        var xOffset = self.bounds.width - badgeWidth
        var yOffset:CGFloat = 0
        for var i = 0 ; i < badgeLabelsNum ; i++
        {
            var badgeLabel = UILabel(frame: CGRectMake(xOffset, yOffset, badgeWidth, badgeHeight))
            badgeLabel.textColor = UIColor.blackColor()
            badgeLabel.textAlignment = NSTextAlignment.Right
            badgeLabel.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0)
            badgeLabel.text = "😍"
            self.addSubview(badgeLabel)
            badgeLabels.append(badgeLabel)
            
            xOffset -= (badgeWidth / 2)
            if xOffset <= bounds.width / 4
            {
                xOffset = (bounds.width - badgeWidth)
                yOffset -=  CGFloat(badgeHeight / 2)
            }
        }
    }
    
    func tapInfo()
    {
        let width = bounds.width
        let height = bounds.height
        let margin:CGFloat = 2
        infoTextView.frame = CGRectMake(width  * -1, (height / 1.5) * -1, width, height)
        infoText.frame = CGRectMake(margin, margin, width - (margin * 2), height - (margin * 2))
        
        println("  eventlabel maxx \(self.frame.maxX) minx \(self.frame.minX) scrollviewBaseView width \(self.superview!.bounds.width)")
        
        if self.frame.minX <= 0
        {
            infoTextView.frame.offset(dx: infoTextView.frame.width + self.frame.width, dy: 0)
        }
        if self.frame.minY <= 0
        {
            infoTextView.frame.offset(dx: 0, dy: self.frame.height)
        }
        
        infoTextView.transform = CGAffineTransformScale(infoTextView.transform, 0.1, 0.1)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.infoTextView.alpha = 1
            self.infoTextView.transform = CGAffineTransformIdentity
            
            }, completion: { (value: Bool) in
                
                
        })
        

        
    }
}