//
//  TimelineViewController.swift
//  TimeIt
//
//  Created by knut on 29/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics
import QuartzCore

class TimelineViewController: UIViewController,UIScrollViewDelegate {
    
    var timelineScrollView:UIScrollView!
    var scrollviewBaseView:UIView!
    var datactrl:DataHandler!
    let backButton = UIButton()
    let zoomOutButton = UIButton()
    var eventInfoLabel:EventInfoLabel!
    var minscaleWidth:CGFloat!
    
    var itemWidth:CGFloat!
    var itemHeight:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datactrl = DataHandler()
        datactrl.fetchData(fromLevel:minLevel,toLevel: maxLevel)
        
    }
    
    override func viewDidLayoutSubviews() {
     
        timelineScrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height))
        timelineScrollView.backgroundColor = UIColor.whiteColor()
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapOutside:")
        tapGesture.numberOfTapsRequired = 1
        timelineScrollView.addGestureRecognizer(tapGesture)
        
        scrollviewBaseView = UIView(frame: CGRectMake(0, 0, timelineScrollView.frame.width * 2.5, timelineScrollView.frame.height ))

        
        view.addSubview(timelineScrollView)
        
        
        let timelineItems = datactrl.getTimelineItems()
        let margin:CGFloat = 10
        let numberOfMargins = (CGFloat(timelineItems.count) + 1)
        itemWidth = (scrollviewBaseView.frame.size.width - (margin * numberOfMargins)) / CGFloat(timelineItems.count)
        itemHeight = 50.0
        var xVal = margin
        var yVal = scrollviewBaseView.frame.size.height - margin - itemHeight
        

        
        for item in timelineItems
        {
            var answers = numberOfRightAnswersOnTimelinePocket(item)
            var numOfRightAnswers = answers.0.count > 20 ? 20 : answers.0.count
            
            var timelineLabel = UILabel(frame: CGRectMake(xVal, yVal, itemWidth, itemHeight))
            timelineLabel.text = item.formattedTime
            timelineLabel.textAlignment = NSTextAlignment.Center
            timelineLabel.numberOfLines = 1
            timelineLabel.adjustsFontSizeToFitWidth = true
            timelineLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
            timelineLabel.layer.borderColor = UIColor.blackColor().CGColor
            timelineLabel.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.05 * CGFloat(numOfRightAnswers) )
            timelineLabel.layer.borderWidth = 2
            timelineLabel.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: "tapPeriod:")
            tapGesture.numberOfTapsRequired = 1
            timelineLabel.addGestureRecognizer(tapGesture)
            
            
            scrollviewBaseView.addSubview(timelineLabel)
            
            

            if numOfRightAnswers > 0
            {
                answers.0 = shuffle(answers.0)
                var yValForHistEvent = yVal - itemHeight
                for historicEvent:HistoricEvent in answers.0
                {
                    
                    var label = TimelineEventLabel(frame: CGRectMake(xVal, yValForHistEvent, itemWidth, itemHeight),event: historicEvent)
                    let tapGesture = UITapGestureRecognizer(target: self, action: "tapEvent:")
                    tapGesture.numberOfTapsRequired = 1
                    label.addGestureRecognizer(tapGesture)
                    
                    scrollviewBaseView.addSubview(label)
                    
                    yValForHistEvent -= rectangleHeight
                    
                    if yValForHistEvent < 0
                    {
                        break
                    }
                }
            }
            xVal += itemWidth + margin
            
        }
        
        let infoLabelHeight = itemHeight * 2
        let infoLabelWidth = itemWidth * 2
        eventInfoLabel = EventInfoLabel(frame: CGRectMake(infoLabelWidth * -1, infoLabelHeight * -1, infoLabelWidth, infoLabelHeight))
        eventInfoLabel.alpha = 0
        scrollviewBaseView.addSubview(eventInfoLabel)
        
        timelineScrollView.addSubview(scrollviewBaseView)
        timelineScrollView.contentSize = scrollviewBaseView.frame.size
        //timelineScrollView.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height * 0.3)
        timelineScrollView.delegate = self
        minscaleWidth = timelineScrollView.frame.width / scrollviewBaseView.frame.size.width
        //let minscaleHeight = timelineScrollView.frame.height / timelineView.frame.size.height
        //let minScale = max(minscaleWidth, minscaleHeight)
        timelineScrollView.minimumZoomScale =  minscaleWidth
        timelineScrollView.maximumZoomScale = 2.5
        timelineScrollView.zoomScale = minscaleWidth
        

        
        backButton.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - smallButtonSide, 0, smallButtonSide, smallButtonSide)
        backButton.backgroundColor = UIColor.whiteColor()
        backButton.layer.borderColor = UIColor.grayColor().CGColor
        backButton.layer.borderWidth = 1
        backButton.setTitle("🔚", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(backButton)
        
        
        
        zoomOutButton.frame = CGRectMake(backButton.frame.minX, backButton.frame.maxY + (margin / 2), smallButtonSide, smallButtonSide)

        zoomOutButton.backgroundColor = UIColor.whiteColor()
        zoomOutButton.layer.borderColor = UIColor.grayColor().CGColor
        zoomOutButton.layer.borderWidth = 1
        zoomOutButton.setTitle("🔎", forState: UIControlState.Normal)
        zoomOutButton.addTarget(self, action: "zoomAction", forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(zoomOutButton)
        let minus = UILabel(frame: CGRectMake(3 , -4, zoomOutButton.frame.width, zoomOutButton.frame.height))
        minus.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        minus.textAlignment = NSTextAlignment.Center
        minus.textColor = UIColor.blackColor()
        minus.text = "-"
        zoomOutButton.addSubview(minus)
    }
    
    var lastTappedEvent:TimelineEventLabel?
    func tapEvent(sender:UITapGestureRecognizer)
    {
        var label = sender.view as! TimelineEventLabel
        if label == lastTappedEvent
        {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.eventInfoLabel.transform = CGAffineTransformIdentity
                self.eventInfoLabel.center = self.lastTappedEvent!.center
                self.eventInfoLabel.alpha = 0
                
                }, completion: { (value: Bool) in
                    self.eventInfoLabel.center = CGPointMake(self.eventInfoLabel.center.x * -1, self.eventInfoLabel.center.y * -1)
                    self.eventInfoLabel.alpha = 0
                    
            })
        }
        else
        {
            eventInfoLabel.center = label.center
            
            if( eventInfoLabel.frame.maxX > scrollviewBaseView.bounds.width)
            {
                eventInfoLabel.frame.offset(dx: scrollviewBaseView.bounds.width - eventInfoLabel.frame.maxX, dy: 0)
            }
            else if(eventInfoLabel.frame.minX < 0)
            {
                eventInfoLabel.frame.offset(dx: eventInfoLabel.frame.minX * -1, dy: 0)
            }
            
            if( eventInfoLabel.frame.minY < 0)
            {
                eventInfoLabel.frame.offset(dx: 0, dy: eventInfoLabel.frame.minY * -1)
            }
            
            var scale:CGFloat = 0.1
            eventInfoLabel.transform = CGAffineTransformScale(label.transform, scale,scale)
            eventInfoLabel.setText(label.event)
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                self.eventInfoLabel.transform = CGAffineTransformIdentity
                self.eventInfoLabel.alpha = 1

                }, completion: { (value: Bool) in
                    self.lastTappedEvent = label
            })
        }
    }
    
    var lastTappedPeriod = UILabel()
    func tapPeriod(sender:UITapGestureRecognizer)
    {
        var label = sender.view as! UILabel
        label.layer.borderWidth = 4
        var xPos = label.frame.minX
        var yPosForceBottomOfScroll:CGFloat = 9999 //self.timelineScrollView.contentOffset.y + self.timelineScrollView.frame.height
        self.timelineScrollView.zoomToRect(CGRectMake(xPos - label.frame.width, yPosForceBottomOfScroll , label.frame.width * 3, label.frame.height * 3), animated: true)
        lastTappedPeriod.layer.borderWidth = 2
        lastTappedPeriod = label
    }
    
    func tapOutside(sender:UITapGestureRecognizer)
    {
        if let tappedEvent = lastTappedEvent
        {
            UIView.animateWithDuration(0.25, animations: { () -> Void in
                tappedEvent.transform = CGAffineTransformIdentity
                self.eventInfoLabel.transform = CGAffineTransformIdentity
                self.eventInfoLabel.center = self.lastTappedEvent!.center
                self.eventInfoLabel.alpha = 0
                
                }, completion: { (value: Bool) in
                    self.lastTappedEvent = nil
                    self.eventInfoLabel.center = CGPointMake(self.eventInfoLabel.center.x * -1, self.eventInfoLabel.center.y * -1)
                    self.eventInfoLabel.alpha = 0
             })
        }
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        
        var offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
        var offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
        
        scrollviewBaseView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
            scrollView.contentSize.height * 0.5 + offsetY);
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return scrollviewBaseView
    }
    
    func backAction()
    {
        self.performSegueWithIdentifier("segueFromTimelineToMainMenu", sender: nil)
    }
    
    func zoomAction()
    {
        self.timelineScrollView.zoomToRect(scrollviewBaseView.frame, animated: true)
        
        timelineScrollView.zoomScale = minscaleWidth
    }
    
    

    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        print("supportedInterfaceOrientations")
        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeLeft
    }

    func numberOfRightAnswersOnTimelinePocket(period:Period) -> ([HistoricEvent],[HistoricEvent])
    {
        var collectionOfRightAnsweredQuestions:[HistoricEvent] = []
        var collectionOfNotRightAnswQuestions:[HistoricEvent] = []
        for eventItem in period.events
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
            for eventItem in periodItem.events
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
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let ecount = count(list)
        for i in 0..<(ecount - 1) {
            let j = Int(arc4random_uniform(UInt32(ecount - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }

}