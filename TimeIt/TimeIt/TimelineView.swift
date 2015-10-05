//
//  File.swift
//  TimeIt
//
//  Created by knut on 17/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

protocol TimelineDelegate
{
    func finishedAnimatingTimeline()
}

class TimelineView: UIView {

    var delegate:TimelineDelegate?
    var timelineItems:[Period]?
    let maringLeft:CGFloat = rectangleWidth * 0.25
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    
    init(frame: CGRect,timelineItems:[Period]) {
        super.init(frame: frame)
        
        
        self.backgroundColor = UIColor.whiteColor()
        
        self.timelineItems = timelineItems
        //testText = UILabel(frame: CGRectMake(0, 0, 100, 50))
        //self.addSubview(testText)
        

    }
    
    override func drawRect(rect: CGRect) {

        
        let ctx = UIGraphicsGetCurrentContext()
        //CGContextSetTextMatrix(ctx, CGAffineTransformIdentity)
        //CGContextTranslateCTM(ctx, 0.0, rect.height)
        //CGContextScaleCTM(ctx, 1.0, -1.0)
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .Center
        let attrs = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 24)!, NSParagraphStyleAttributeName: paragraphStyle, NSForegroundColorAttributeName : UIColor(white: 0.0, alpha: 1.0).CGColor]

        
        var xVal:CGFloat = maringLeft
        let yVal:CGFloat = rect.height
        let yValForPocket = yVal - (rectangleHeight * 2)
        let yValForPeriodText = yVal - rectangleHeight
        for item in timelineItems!
        {
            var answers = numberOfRightAnswersOnTimelinePocket(item)
            let numOfRightAnswers = answers.0.count
            CGContextAddRect(ctx, CGRectMake(xVal, yValForPocket, rectangleWidth, rectangleHeight))
            CGContextSetLineWidth(ctx, 5);
            CGContextSetStrokeColorWithColor(ctx, UIColor.grayColor().CGColor)
            CGContextStrokePath(ctx)
        
            var alphaValue:CGFloat = CGFloat(numOfRightAnswers) * 0.1
            alphaValue = alphaValue >= 1.0 ? 1.0 : alphaValue
            CGContextSetFillColorWithColor(ctx, UIColor.greenColor().colorWithAlphaComponent(alphaValue).CGColor)
            CGContextAddRect(ctx, CGRectMake(xVal, yValForPocket, rectangleWidth, rectangleHeight))
            CGContextFillPath(ctx)

            let string = "\(item.formattedTime)\n"
            string.drawWithRect(CGRect(x: xVal, y: yValForPeriodText, width: rectangleWidth, height: rectangleHeight), options: .UsesLineFragmentOrigin, attributes: attrs as? [String : AnyObject], context: nil)
            
            if numOfRightAnswers > 0
            {
                answers.0 = shuffle(answers.0)
                //let maxIteration = numOfRightAnswers > 5 ?  5 : numOfRightAnswers
                var yValForHistEvent = yValForPocket - rectangleHeight
                for historicEvent:HistoricEvent in answers.0
                {
                    
                    let string = "\(historicEvent.title)\n"
                    string.drawWithRect(CGRect(x: xVal, y: yValForHistEvent, width: rectangleWidth, height: rectangleHeight), options: .UsesLineFragmentOrigin, attributes: attrs as? [String : AnyObject], context: nil)
                    
                    yValForHistEvent -= rectangleHeight
                    
                    if yValForHistEvent < 0
                    {
                        break
                    }
                }
            }
            
            
            xVal += rectangleWidth
        }
    }
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let ecount = list.count
        for i in 0..<(ecount - 1) {
            let j = Int(arc4random_uniform(UInt32(ecount - i))) + i
            if j != i {
                swap(&list[i], &list[j])
            }
        }
        return list
    }
    
    func numberOfRightAnswersOnTimelinePocket(period:Period) -> ([HistoricEvent],[HistoricEvent])
    {
        var collectionOfRightAnsweredQuestions:[HistoricEvent] = []
        var collectionOfNotRightAnswQuestions:[HistoricEvent] = []
        for eventItem in period.hevents
        {
            if (eventItem as! HistoricEvent).goodScore > 0
            {
                collectionOfRightAnsweredQuestions.append(eventItem as! HistoricEvent)
            }
            else
            {
                collectionOfNotRightAnswQuestions.append(eventItem as! HistoricEvent)
            }
        }
        collectRightAnswers(period,collectionRight: &collectionOfRightAnsweredQuestions,collectionNotRight: &collectionOfNotRightAnswQuestions)
        return (collectionOfRightAnsweredQuestions,collectionOfNotRightAnswQuestions)
        
    }
    
    func collectRightAnswers(period:Period,inout collectionRight:[HistoricEvent],inout collectionNotRight:[HistoricEvent])
    {

        for periodItem in period.periods
        {
            for eventItem in periodItem.hevents
            {
                if (eventItem as! HistoricEvent).goodScore > 0
                {
                     collectionRight.append(eventItem as! HistoricEvent)
                }
                else
                {
                    collectionNotRight.append(eventItem as! HistoricEvent)
                }
            }
            collectRightAnswers(periodItem as! Period,collectionRight: &collectionRight, collectionNotRight: &collectionNotRight)
        }

    }
    
    
    func drawText(context: CGContextRef, text: NSString, attributes: [String: AnyObject], x: CGFloat, y: CGFloat) -> CGSize {
        let font = attributes[NSFontAttributeName] as! UIFont
        let attributedString = NSAttributedString(string: text as String, attributes: attributes)
        
        let textSize = text.sizeWithAttributes(attributes)
        
        // y: Add font.descender (its a negative value) to align the text at the baseline
        let textPath    = CGPathCreateWithRect(CGRect(x: x, y: y + font.descender, width: ceil(textSize.width), height: ceil(textSize.height)), nil)
        let frameSetter = CTFramesetterCreateWithAttributedString(attributedString)
        let frame       = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: attributedString.length), textPath, nil)
        
        CTFrameDraw(frame, context)
        
        return textSize
    }
    
    func getXPosOfTimelineItem(period:Period) -> CGFloat
    {
        var xVal:CGFloat = maringLeft
        for item in timelineItems!
        {
            if self.periodHittingPeriod(period, hitting: item)
            {
                break
            }
            xVal += rectangleWidth
        }
        return xVal
    }
    
    
    
    func animateTimelinePocket(period:Period, scale:CGFloat)
    {
        var viewForAnimation:UIView?
        var xVal:CGFloat = maringLeft
        let yVal:CGFloat = self.frame.size.height / scale
        let yValForPocket = yVal - (rectangleHeight * 2)

        for item in timelineItems!
        {
            //println("check hitting \(item.fromYear) to \(item.toYear)")
            if self.periodHittingPeriod(period, hitting: item)
            {
                viewForAnimation = UIView(frame: CGRectMake(xVal, yValForPocket, rectangleWidth, rectangleHeight))
                viewForAnimation!.backgroundColor = UIColor.blueColor()
                viewForAnimation?.alpha = 0
                self.addSubview(viewForAnimation!)
                
                let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
                
                pulseAnimation.delegate = self
                UIView.setAnimationDelegate(self)
                //UIView.setAnimationDidStopSelector("pulsStopped:")
                pulseAnimation.duration = 0.3
                pulseAnimation.toValue = NSNumber(float: 0.3)
                pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                pulseAnimation.autoreverses = true;
                pulseAnimation.repeatCount = 5
                viewForAnimation!.layer.addAnimation(pulseAnimation, forKey: "asd")

                break
            }
            xVal += rectangleWidth
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        delegate?.finishedAnimatingTimeline()
    }

    
    
    func periodHittingPeriod(questionPeriod:Period?,hitting:Period?) -> Bool
    {
        var isHitting = false
        
        var tempPeriod = questionPeriod
        while tempPeriod != nil && !isHitting
        {
            if(tempPeriod == hitting)
            {
                isHitting = true
            }
            
            tempPeriod = tempPeriod!.period
        }
        return isHitting
    }
}