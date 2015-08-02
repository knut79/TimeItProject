//
//  PlayViewController.swift
//  TimeIt
//
//  Created by knut on 12/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import UIKit
import iAd

class PlayViewController: UIViewController, UIScrollViewDelegate, TimelineDelegate, ADBannerViewDelegate{
    
    var buttonPool:[UIButton]!
    
    var milleniaCollecton:[Period]!
    var fivehundredCollecton:[Period]!
    var gameStats:GameStats!
    
    var questionLabel:UILabel!
    var timelineScrollView:UIScrollView!
    var timelineView:TimelineView!
    var datactrl:DataHandler!
    var minscaleWidth:CGFloat!
    
    var answerAnimationLabel:UILabel!
    var originalCenterQueston:CGPoint!
    
    let rangeSlider = RangeSlider(frame: CGRectZero)
    let rangeMaxLabel = UILabel()
    let rangeMinLabel = UILabel()
    let rangeButton = UIButton()
    let rangeBaileOutText = "Baile out!"
        var rangeReset = true

    let backButton = UIButton()
    var rightPeriodStrikes:Int = 0
    
    var answerButtonReadyForText:Bool = false

    var bannerView:ADBannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        bannerView = ADBannerView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width, 44))
        //bannerView = ADBannerView(frame: CGRectZero)
        self.view.addSubview(bannerView!)
        self.bannerView?.delegate = self
        self.bannerView?.hidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
        datactrl = DataHandler()
        datactrl.fetchData()
        datactrl.shuffleEvents()
        
        gameStats = GameStats(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width * 0.75, UIScreen.mainScreen().bounds.size.height * 0.08),okScore: 0,goodScore: 0,loveScore: 0)
        
        //timelineScrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height * 0.20))
        timelineScrollView = UIScrollView(frame: CGRectMake(0, gameStats.frame.maxY, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height * 0.20))
        timelineScrollView.backgroundColor = UIColor.whiteColor()
        let timelineItems = datactrl.getTimelineItems()
        let maringLeftAndRight = rectangleWidth / 2
        timelineView = TimelineView(frame: CGRectMake(0, 0, (CGFloat(timelineItems.count) * rectangleWidth) + maringLeftAndRight, timelineScrollView.frame.height * 3),timelineItems: timelineItems )
        timelineView!.delegate = self
        timelineScrollView.addSubview(timelineView)
        timelineScrollView.contentSize = timelineView.frame.size
        timelineScrollView.delegate = self
        minscaleWidth = timelineScrollView.frame.width / timelineView.frame.size.width
        timelineScrollView.minimumZoomScale =  minscaleWidth
        timelineScrollView.maximumZoomScale = 1.0
        timelineScrollView.zoomScale = minscaleWidth

        answerAnimationLabel = UILabel(frame: CGRectMake(0, 0, rectangleWidth,rectangleHeight))
        answerAnimationLabel.font = UIFont.boldSystemFontOfSize(24)
        answerAnimationLabel.textAlignment = NSTextAlignment.Center
        answerAnimationLabel.numberOfLines = 1;
        answerAnimationLabel.adjustsFontSizeToFitWidth = true
        answerAnimationLabel.alpha = 0

        backButton.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width * 0.9, 0, UIScreen.mainScreen().bounds.size.width * 0.1, UIScreen.mainScreen().bounds.size.width * 0.1)
        backButton.backgroundColor = UIColor.whiteColor()
        backButton.layer.borderColor = UIColor.grayColor().CGColor
        backButton.layer.borderWidth = 1
        backButton.setTitle("🔚", forState: UIControlState.Normal)
        backButton.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)

        let margin: CGFloat = 10.0
        questionLabel = UILabel(frame: CGRectMake(margin, timelineScrollView.frame.maxY, UIScreen.mainScreen().bounds.width - (margin * 2), 50))
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.font = UIFont.boldSystemFontOfSize(25)
        questionLabel.numberOfLines = 1
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        originalCenterQueston = questionLabel.center
        //originalCenterQueston = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height * 0.15)
        //questionLabel.center = originalCenterQueston
        
        self.view.addSubview(gameStats)
        self.view.addSubview(answerAnimationLabel)
        view.addSubview(backButton)
        self.view.addSubview(questionLabel)
        self.view.addSubview(timelineScrollView)

        
        startPlay()
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        
        var offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
        var offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
        
        timelineView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
            scrollView.contentSize.height * 0.5 + offsetY);
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView!, atScale scale: CGFloat) {
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return timelineView
    }
    
    /*
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView {
        return timelineView
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        
        if rangeReset
        {
            answerButtonReadyForText = false
            rangeReset = false
            UIView.transitionWithView(rangeButton, duration: 0.3, options: UIViewAnimationOptions.TransitionFlipFromRight, animations: { () -> Void in
                
                if rangeSlider.typeValue == sliderType.bothLowerAndUpper
                {
                    self.rangeButton.setTitle("These are\nthe years", forState: UIControlState.Normal)
                }
                else
                {
                    self.rangeButton.setTitle("This is\nthe year", forState: UIControlState.Normal)
                }
                self.rangeButton.layer.borderColor = UIColor.grayColor().CGColor
                
                }, completion: { (value: Bool) in
                    if rangeSlider.typeValue == sliderType.bothLowerAndUpper
                    {
                        self.rangeButton.setTitle("These are\nthe years", forState: UIControlState.Normal)
                    }
                    else
                    {
                        self.rangeButton.setTitle("This is\nthe year", forState: UIControlState.Normal)
                    }
                    self.rangeButton.layer.borderColor = UIColor.grayColor().CGColor
                    
                    let oldRangeMaxCenter = self.rangeMaxLabel.center
                    let oldRangeMinCenter = self.rangeMinLabel.center
                    if self.currentQuestion.type == Int16(eventType.singleYear.rawValue)
                    {
                        UIView.animateWithDuration(0.30, animations: { () -> Void in
                            
                            self.rangeMinLabel.center = self.rangeButton.center
                            self.rangeMaxLabel.center = self.rangeButton.center
                            
                            
                            }, completion: { (value: Bool) in
                                self.rangeButton.setTitle("\(rangeSlider.formattedLowerValue) is\nthe year", forState: UIControlState.Normal)
                                self.rangeMinLabel.center = oldRangeMinCenter
                                self.rangeMaxLabel.center = oldRangeMaxCenter
                                self.rangeMinLabel.alpha = 0
                                self.rangeMaxLabel.alpha = 0
                                self.answerButtonReadyForText = true
                        })
                    }
                    //animate min and

            })
        }
        
        if rangeSlider.typeValue == sliderType.single
        {
            if answerButtonReadyForText
            {
                self.rangeButton.setTitle("\(rangeSlider.formattedLowerValue) is\nthe year", forState: UIControlState.Normal)
            }
            
            rangeMinLabel.text = rangeSlider.formattedLowerValue //"\(Int(rangeSlider.lowerValue))"
            rangeMaxLabel.text = rangeMinLabel.text
        }
        else
        {
            
            if rangeSlider.typeValue != sliderType.justUpper
            {
                rangeMinLabel.text = rangeSlider.formattedLowerValue //"\(Int(rangeSlider.lowerValueString()))"
            }
            if rangeSlider.typeValue != sliderType.justLower
            {
                rangeMaxLabel.text = rangeSlider.formattedUpperValue //"\(Int(rangeSlider.upperValue))"
            }
        }
        
        println("Range slider value changed: (\(Int(rangeSlider.lowerValue)) \(Int(rangeSlider.upperValue)))")
    }
    
    func resetRange()
    {
        setAlphaOnRangeItems(0)
        rangeReset = true
        rangeMaxLabel.text = ""
        rangeMaxLabel.textColor = UIColor.blackColor()
        rangeMinLabel.text = ""
        rangeMinLabel.textColor = UIColor.blackColor()
        rangeButton.layer.borderColor = UIColor.redColor().CGColor
        rangeButton.setTitle(rangeBaileOutText, forState: UIControlState.Normal)
    }
    
    var currentQuestion:HistoricEvent!
    var buttonCollection:[PeriodButton]!
    var index = 0
    func startPlay()
    {
        
        buttonCollection = []
        
        setupRanger()

        setNextQuestion()
    }
    
    func setupRanger()
    {
        let height:CGFloat = 31.0
        let margin: CGFloat = 20.0
        let rangeSliderWidth = view.bounds.width - 2.0 * margin
        let rangeSliderCenterX = margin + (rangeSliderWidth / 2)
        
        let buttonAndLabelHeight = height * 2
        let buttonAndLabelWidth:CGFloat = (UIScreen.mainScreen().bounds.width - (margin * 2)) / 3
        rangeButton.frame = CGRect(x:  (UIScreen.mainScreen().bounds.width / 2) - (buttonAndLabelWidth/2), y: questionLabel.frame.maxY + margin  ,
            width: buttonAndLabelWidth, height: buttonAndLabelHeight)
        //rangeButton.backgroundColor = UIColor.redColor()
        rangeButton.layer.borderWidth = 1
        rangeButton.layer.borderColor = UIColor.redColor().CGColor
        rangeButton.backgroundColor = UIColor.whiteColor()
        rangeButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        rangeButton.addTarget(self, action: "bonusAction:", forControlEvents: UIControlEvents.TouchUpInside)
        rangeButton.titleLabel!.numberOfLines = 1
        rangeButton.titleLabel!.adjustsFontSizeToFitWidth = true
        //rangeButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByClipping
        rangeButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        rangeButton.titleLabel?.textAlignment = NSTextAlignment.Center
        rangeButton.titleLabel?.preferredMaxLayoutWidth = rangeButton.frame.size.width - 6
        rangeButton.setTitle("Baile out!", forState: UIControlState.Normal)

        //let labelWidth = UIScreen.mainScreen().bounds.width * 0.2
        //rangeMinLabel.frame = CGRectMake(rangeSliderCenterX - (rangeSliderWidth * 0.25 ) - (labelWidth / 2),rangeButton.frame.maxY, labelWidth, height)
        rangeMinLabel.frame = CGRectMake(rangeButton.frame.minX - buttonAndLabelWidth ,rangeButton.frame.minY, buttonAndLabelWidth, buttonAndLabelHeight)
        rangeMinLabel.textAlignment = NSTextAlignment.Left
        rangeMinLabel.text = ""
        
        //rangeMaxLabel.frame = CGRectMake(rangeSliderCenterX + (rangeSliderWidth * 0.25 ) - (labelWidth / 2), rangeButton.frame.maxY, labelWidth, height)
        rangeMaxLabel.frame = CGRectMake(rangeButton.frame.maxX, rangeButton.frame.minY, buttonAndLabelWidth, buttonAndLabelHeight)
        rangeMaxLabel.textAlignment = NSTextAlignment.Right
        rangeMaxLabel.text = ""
        
        rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        

        rangeSlider.frame = CGRect(x:  margin, y: rangeMinLabel.frame.maxY + margin ,
            width: rangeSliderWidth, height: height)
        rangeSlider.curvaceousness = 0.0
        
        self.view.addSubview(rangeButton)
        self.view.addSubview(rangeMinLabel)
        self.view.addSubview(rangeMaxLabel)
        self.view.addSubview(rangeSlider)
        
        setAlphaOnRangeItems(0)


    }
    
    func setAlphaOnRangeItems(value:CGFloat)
    {
        rangeMinLabel.alpha = value
        rangeMaxLabel.alpha = value
        rangeButton.alpha = value
        rangeSlider.alpha = value
        
        rangeSlider.setNeedsDisplay()
    }
    
    
    func setNextQuestion()
    {
        currentQuestion = datactrl.historicEventItems[index % datactrl.historicEventItems.count]
        UIView.animateWithDuration(0.50, animations: { () -> Void in
            self.questionLabel.center = CGPointMake(0 - self.questionLabel.frame.width, self.originalCenterQueston.y)

            }, completion: { (value: Bool) in
                self.questionLabel.center = CGPointMake(UIScreen.mainScreen().bounds.width + self.questionLabel.frame.width, self.originalCenterQueston.y)
                self.questionLabel.text = self.currentQuestion.title
               
                UIView.animateWithDuration(0.50, animations: { () -> Void in
                    self.questionLabel.center = self.originalCenterQueston
                    
                    }, completion: { (value: Bool) in
                            self.questionLabel.center = self.originalCenterQueston
                })
                
        })
        index++
        
        var tempPeriodItemsOnType:[Period] = []


        if rightPeriodStrikes >= 3
        {
            var periodsOneLevelFromEvent = ((currentQuestion.periods.allObjects as! [Period])[0] as Period).period?.sortedPeriods
            if periodsOneLevelFromEvent == nil
            {
                println("Could not get periods one level up for question \(currentQuestion.title)")
                setNextQuestion()
            }
            else
            {
                //show from 1000 year periods
                for item in periodsOneLevelFromEvent!
                {
                    tempPeriodItemsOnType.append(item as! Period)
                }
            }
        }
        else if rightPeriodStrikes >= 1
        {
            var periodsToLevelsFromEvent = ((currentQuestion.periods.allObjects as! [Period])[0] as Period).period?.period?.sortedPeriods
            if periodsToLevelsFromEvent == nil
            {
                println("Could not get periods to levels up for question \(currentQuestion.title)")
                setNextQuestion()
            }
            else
            {
            //show from 1000 year periods
                for item in periodsToLevelsFromEvent!
                {
                    tempPeriodItemsOnType.append(item as! Period)
                }
            }
        }
        else
        {
            //show only to levels up from event
            for item in datactrl.periodsItems
            {
                if item.type == Int16(periodType.millenia.rawValue)
                {
                    tempPeriodItemsOnType.append(item)
                }
            }
        }
            
        if( tempPeriodItemsOnType.count > 0)
        {
            var xMaxBound:CGFloat = UIScreen.mainScreen().bounds.size.width
            var xMinBound:CGFloat = 0
            cleanUpButtons()
            layoutButtons(nil,periods: tempPeriodItemsOnType, xMinBoundary: xMinBound, xMaxBoundary: xMaxBound,yBoundary: UIScreen.mainScreen().bounds.size.height / 2, level: 1)
        }
        
    }
    
    let defaultButtonHeight:CGFloat = 70
    func layoutButtons(parentButton:PeriodButton?, periods:[Period],xMinBoundary:CGFloat, xMaxBoundary:CGFloat, yBoundary:CGFloat, buttonHeight:CGFloat = 70,level:Int)
    {
        var buttonWidth = (xMaxBoundary - xMinBoundary) / CGFloat(periods.count)
        var x:CGFloat = xMinBoundary
        var collectionForRelation:[PeriodButton] = []
        for item in periods
        {
            var periodButton = PeriodButton(frame:CGRectMake(0, 0, buttonWidth,buttonHeight), level:level)
            //periodButton.titleLabel!.minimumFontSize = 5


            periodButton.addTarget(self, action: "periodSelected:", forControlEvents: .TouchUpInside)
            periodButton.setPeriodAndTitle(item as Period)
            buttonCollection.append(periodButton)
            collectionForRelation.append(periodButton)
            periodButton.center = CGPointMake(x + (periodButton.frame.width/2), yBoundary)
            
            if periodButton.frame.size.width < (UIScreen.mainScreen().bounds.size.width / 4)
            {
                periodButton.titleLabel?.font = UIFont.systemFontOfSize(10)
            }
            if buttonHeight < CGFloat(70)
            {
                periodButton.enabled = false
                periodButton.backgroundColor = UIColor.lightGrayColor()
            }

            self.view.addSubview(periodButton)

            var tempPeriodItemsOnType:[Period] = []
            for item in item.sortedPeriods
            {
                tempPeriodItemsOnType.append(item as! Period)
            }
            layoutButtons(periodButton,periods: tempPeriodItemsOnType, xMinBoundary: x, xMaxBoundary: x + periodButton.frame.size.width, yBoundary: yBoundary + periodButton.frame.size.height, buttonHeight: buttonHeight / 2 , level: level + 1)
            
             x += periodButton.frame.width
        }
        
        if parentButton != nil
        {
            parentButton!.childButtons = collectionForRelation
        }
     
    }
    
    func periodSelected(sender: PeriodButton)
    {
        //animate!!!
        var orgPoint = sender.center
        self.view.bringSubviewToFront(sender)
        UIView.animateWithDuration(0.50, animations: { () -> Void in
            
            for item in self.buttonCollection
            {
                if !self.buttonInButtonHirarcy(item,buttonHirarcy: sender)
                {
                    item.alpha = 0
                }
            }
            
            sender.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, sender.center.y - 100)
            var x:CGFloat = 0
            var buttonWidth = UIScreen.mainScreen().bounds.size.width / CGFloat(sender.childButtons.count)
            for item in sender.childButtons
            {
                item.frame = CGRectMake(0,0, buttonWidth, self.defaultButtonHeight)
                item.backgroundColor = UIColor.greenColor()
                item.center = CGPointMake(x + (item.frame.width/2), UIScreen.mainScreen().bounds.size.height / 2)
                
                //var childX:CGFloat = oldParentX
                var childButtonWidth = item.frame.size.width / CGFloat(item.childButtons.count)
                var childX:CGFloat = item.frame.minX
                for childItem in item.childButtons
                {
                    childItem.frame = CGRectMake(0,0, childButtonWidth, self.defaultButtonHeight / 2)
                    childItem.center = CGPointMake(childX + (childItem.frame.width/2), (UIScreen.mainScreen().bounds.size.height / 2) + item.frame.height)
                    childX += childItem.frame.width
                }
                
                x += item.frame.width
            }
            
            }, completion: { (value: Bool) in
                
            //animate button desolvement
            UIView.animateWithDuration(0.25, animations: { () -> Void in

                sender.alpha = 0
                }, completion: { (value: Bool) in
                    self.periodSelectedFinalize(sender)
            })
        })

    }
    
    func buttonInButtonHirarcy(button:PeriodButton,buttonHirarcy:PeriodButton) -> Bool
    {
        var found = false
        if(button == buttonHirarcy)
        {
            found = true
        }
        else
        {
            for childButton in buttonHirarcy.childButtons
            {
                if button == childButton
                {
                    found = true
                }
                else
                {
                    found = buttonInButtonHirarcy(button, buttonHirarcy: childButton)

                }
                if found
                {
                    break
                }
            }
        }
        return found
    }
    
    func periodSelectedFinalize(sender: PeriodButton)
    {
        var givePointsForRightAnswer = false
        for period in currentQuestion.periods
        {
            if period as! Period == sender.period
            {
                givePointsForRightAnswer = true
                break
            }
        }
        if(givePointsForRightAnswer)
        {
            rightAnswerGiven(sender)
        }
        else
        {
            var rightTrack = isOnRightTrack(sender.period)
            if rightTrack
            {
                givePointsForRightPath(sender)
                continuePlayingWithNewPeriods(sender)
            }
            else
            {
                wrongAnswerGiven(sender)
            }
        }
    }
    
    func givePointsForRightPath(periodButton:PeriodButton)
    {
        let points = periodButton.level * 5
        answerAnimationLabel.textColor = UIColor.greenColor()
        self.view.bringSubviewToFront(answerAnimationLabel)
        let xOffset = self.gameStats.okPointsView.center.x
        answerAnimationLabel.center = CGPointMake(xOffset,periodButton.center.y)
        answerAnimationLabel.text = "\(points)"
        answerAnimationLabel.alpha = 1
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.answerAnimationLabel.center = self.gameStats.okPointsView.center
            
            }, completion: { (value: Bool) in
                self.gameStats.addOkPoints(points)
                self.datactrl.updateOkScore(self.currentQuestion, deltaScore:points)
                self.answerAnimationLabel.alpha = 0
        })
    }
    
    var lastRightPeriodButtonClicked:PeriodButton!
    func rightAnswerGiven(periodButton:PeriodButton)
    {
        let points = periodButton.level * 10
        rightPeriodStrikes = rightPeriodStrikes + 1
        lastRightPeriodButtonClicked = periodButton
        answerAnimationLabel.textColor = UIColor.greenColor()
        self.view.bringSubviewToFront(answerAnimationLabel)
        answerAnimationLabel.center = periodButton.center//CGPointMake(periodButton.frame.maxX, periodButton.frame.maxY)
        answerAnimationLabel.text = "\(points)"
        answerAnimationLabel.alpha = 1
        //animate zoominrect
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            var xPos = self.timelineView.getXPosOfTimelineItem(periodButton.period)
            var yPosForceBottomOfScroll:CGFloat = 9999 //self.timelineScrollView.contentOffset.y + self.timelineScrollView.frame.height
            self.timelineScrollView.zoomToRect(CGRectMake(xPos - rectangleWidth, yPosForceBottomOfScroll , rectangleWidth * 3, self.timelineScrollView.frame.height), animated: true)
            let xOffset = self.gameStats.okPointsView.center.x
            self.answerAnimationLabel.center = CGPointMake(xOffset, self.gameStats.center.y)
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 1.5, 1.5)
            }, completion: { (value: Bool) in
                self.answerAnimationLabel.transform = CGAffineTransformIdentity
                self.gameStats.addOkPoints(points)
                self.datactrl.updateOkScore(self.currentQuestion, deltaScore:points)
                self.answerAnimationLabel.alpha = 0
                self.timelineView.setNeedsDisplay()
                self.timelineView.animateTimelinePocket(periodButton.period, scale:self.timelineScrollView.zoomScale)
                
                self.bonusQuestion(periodButton)
        })
    }
    
    func wrongAnswerGiven(periodButton:PeriodButton)
    {
        let points = periodButton.level * 3
        rightPeriodStrikes = 0
        answerAnimationLabel.textColor = UIColor.redColor()
        answerAnimationLabel.center = periodButton.center
        self.view.bringSubviewToFront(answerAnimationLabel)
        answerAnimationLabel.text = "😫 \(currentQuestion.formattedTime)"
        answerAnimationLabel.alpha = 1
        //animate zoominrect
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            for button:UIButton in self.buttonCollection
            {
                button.alpha = 0
            }
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 2, 2)
            self.answerAnimationLabel.center = CGPointMake(self.answerAnimationLabel.center.x, self.answerAnimationLabel.center.y - self.answerAnimationLabel.frame.height )
            }, completion: { (value: Bool) in
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 0.5, 0.5)
                    self.answerAnimationLabel.alpha = 0
                    }, completion: { (value: Bool) in
                        self.answerAnimationLabel.transform = CGAffineTransformIdentity
                        self.gameStats.subtractOkPoints(points)
                        self.datactrl.updateOkScore(self.currentQuestion, deltaScore:points * -1)
                })
                //self.timelineView.animateTimelinePocket(periodButton.period, scale:self.timelineScrollView.zoomScale)
                self.setNextQuestion()
        })
    }

    
    func bonusQuestion(periodButton:PeriodButton)
    {
        rangeSlider.maximumValue = Double(periodButton.period.toYear)
        rangeSlider.minimumValue = Double(periodButton.period.fromYear)

        if currentQuestion.type == Int16(eventType.singleYear.rawValue)
        {
            rangeSlider.typeValue = sliderType.single
            
        }
        else
        {
            if currentQuestion.periods.count > 1
            {
                if currentQuestion.fromYear < periodButton.period.fromYear
                {
                    rangeSlider.typeValue = sliderType.justUpper
                    rangeMinLabel.text = currentQuestion.formattedFromYear
                    rangeMinLabel.textColor = UIColor.grayColor()
                }
                else if currentQuestion.toYear > periodButton.period.toYear
                {
                    rangeSlider.typeValue = sliderType.justLower
                    rangeMaxLabel.text = currentQuestion.formattedToYear
                    rangeMaxLabel.textColor = UIColor.grayColor()
                }
            }
            else
            {
                rangeSlider.typeValue = sliderType.bothLowerAndUpper
            }
        }

        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
                for button in self.buttonCollection
                {
                    button.alpha = 0
                }
            
            self.setAlphaOnRangeItems(1)
            
            }, completion: { (value: Bool) in
                self.cleanUpButtons()
        })
    }
    
    func bonusAction(sender:UIButton)
    {
        //if rangeReset is true no year values are set
        if rangeReset
        {
            giveNoBonus(sender, completionClosure: { () in
                self.resetRange()
                self.setNextQuestion()
            })
        }
        else
        {
            switch rangeSlider.typeValue
            {
            case sliderType.justLower:
                let points = valueWithinRange(Int(rangeSlider.lowerValue), questionValue: Int(currentQuestion.fromYear))
                if points > 0
                {
                    giveBonus(points, animateFromView: rangeMinLabel, completionClosure: { () in
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
                else
                {
                    giveNoBonus(rangeMinLabel, completionClosure: { () in
                        self.gameStats.subtractGoodPoints(1)
                        self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
            case sliderType.justUpper:
                let points = valueWithinRange(Int(rangeSlider.upperValue),questionValue: Int(currentQuestion.toYear))
                if points > 0
                {
                    giveBonus(points, animateFromView: rangeMaxLabel, completionClosure: { () in
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
                else
                {
                    giveNoBonus(sender,completionClosure: { () in
                        self.gameStats.subtractGoodPoints(1)
                        self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
            case sliderType.single:
                //from an to year will have the same value
                let points = valueWithinRange(Int(rangeSlider.lowerValue), questionValue: Int(currentQuestion.fromYear))
                if points > 0
                {
                    giveBonus(points, animateFromView: sender, completionClosure: { () in
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
                else
                {
                    giveNoBonus(sender, completionClosure: { () in
                        self.gameStats.subtractGoodPoints(1)
                        self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
            case sliderType.bothLowerAndUpper:
                
                var selectedBits = 0
                let pointsLower = valueWithinRange(Int(rangeSlider.lowerValue), questionValue: Int(currentQuestion.fromYear))
                if pointsLower > 0
                {
                    selectedBits += 1
                    
                }
                let pointsUpper = valueWithinRange(Int(rangeSlider.upperValue), questionValue: Int(currentQuestion.toYear))
                if pointsUpper > 0
                {
                    selectedBits += 2
                }
                
                if selectedBits == 1
                {
                    giveBonus(pointsLower, animateFromView: rangeMinLabel, completionClosure: { () in
                        self.giveNoBonus(self.rangeMaxLabel, completionClosure: { () in
                            self.gameStats.subtractGoodPoints(1)
                            self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
                            self.resetRange()
                            self.setNextQuestion()
                        })
                    })
                    
                }
                else if selectedBits == 2
                {
                    giveNoBonus(rangeMinLabel, completionClosure: { () in
                        self.gameStats.subtractGoodPoints(1)
                        self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
                        self.giveBonus(pointsUpper, animateFromView: self.rangeMaxLabel, completionClosure: { () in
                            self.resetRange()
                            self.setNextQuestion()
                        })
                    })
                    
                    
                }
                else if selectedBits == 3
                {
                    giveBonus(pointsLower, animateFromView: rangeMinLabel, completionClosure: { () in
                        self.giveBonus(pointsUpper, animateFromView: self.rangeMaxLabel, completionClosure: { () in
                            self.resetRange()
                            self.setNextQuestion()
                        })
                    })
                }
                
                if (pointsUpper + pointsLower) <= 0
                {
                    giveNoBonus(sender, completionClosure: { () in
                        
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }
                
            default:
                break
            }
        }
    }
    
    func valueWithinRange(valueGiven:Int,questionValue:Int) -> Int
    {
        let test = Int(questionValue + lastRightPeriodButtonClicked.period.lowPercent())
        let withinUpper10 = valueGiven <= test
        let withinLower10 = valueGiven >= (Int(questionValue - lastRightPeriodButtonClicked.period.lowPercent()))
        println("valueGiven\(valueGiven) questionValue \(questionValue)")
        println("upper10 \(Int(CGFloat(questionValue) * 1.1)) lower10 \(Int(CGFloat(questionValue) * 0.9))")
        
        let withinUpper20 = valueGiven <= (Int(questionValue + lastRightPeriodButtonClicked.period.highPercent()))
        let withinLower20 = valueGiven >= (Int(questionValue + lastRightPeriodButtonClicked.period.lowPercent()))
        if valueGiven == questionValue
        {
            return 3
        }
        else if withinUpper10 && withinLower10
        {
            return 2
        }
        else if withinLower20 && withinUpper20
        {
            return 1
        }
        else
        {
            return 0
        }
    }
    

    func giveNoBonus(animateFromView:UIView ,completionClosure: (() -> (Void))? )
    {
        rangeSlider.higlightWindow((currentQuestion.fromYear,currentQuestion.toYear))

        answerAnimationLabel.textColor = self.rangeReset ? UIColor.blackColor() : UIColor.redColor()
        answerAnimationLabel.center = animateFromView.center
        self.view.bringSubviewToFront(answerAnimationLabel)
        
        answerAnimationLabel.text = {() -> String in
            let smileyIcon = self.rangeReset ? "😕" : "😫"
            if(animateFromView == self.rangeMinLabel)  //|| self.currentQuestion.type == Int16(eventType.singleYear.rawValue))
            {
                return "\(smileyIcon) \(self.currentQuestion.formattedFromYear)"
            }
            else if animateFromView == self.rangeMaxLabel
            {
                return "\(smileyIcon) \(self.currentQuestion.formattedToYear)"
            }
            else
            {
                return  "\(smileyIcon) \(self.currentQuestion.formattedTime)"
            }
        }()
        
        
        answerAnimationLabel.alpha = 1
        //animate zoominrect
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            //self.answerAnimationLabel.center = CGPointMake(self.answerAnimationLabel.center.x, self.answerAnimationLabel.center.y - 100)
            self.answerAnimationLabel.center = CGPointMake(UIScreen.mainScreen().bounds.width / 2, self.answerAnimationLabel.center.y - 100)
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 2, 2)
            }, completion: { (value: Bool) in
                
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 0.5, 0.5)
                    self.answerAnimationLabel.alpha = 0
                    }, completion: { (value: Bool) in
                        
                        self.answerAnimationLabel.transform = CGAffineTransformIdentity
                        completionClosure!()
                        
                })
        })
    }
    

    
    func giveBonus(points:Int, animateFromView:UIView, completionClosure: (() -> Void)? )
    {

        let lovePoint = points == 3
        
        rangeSlider.higlightWindow((currentQuestion.fromYear,currentQuestion.toYear))
        
        answerAnimationLabel.textColor = UIColor.greenColor()
        self.view.bringSubviewToFront(answerAnimationLabel)
        answerAnimationLabel.center = CGPointMake(animateFromView.frame.maxX, animateFromView.frame.maxY)
        answerAnimationLabel.text = lovePoint ? "😍" : "\(points) x 😀"
        answerAnimationLabel.alpha = 1
        //animate zoominrect
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            var xPos = self.timelineView.getXPosOfTimelineItem(self.lastRightPeriodButtonClicked.period)
            var yPosForceBottomOfScroll:CGFloat = 9999 //self.timelineScrollView.contentOffset.y + self.timelineScrollView.frame.height
            self.timelineScrollView.zoomToRect(CGRectMake(xPos - rectangleWidth, yPosForceBottomOfScroll , rectangleWidth * 3, self.timelineScrollView.frame.height), animated: true)
            let xOffset = lovePoint ? self.gameStats.lovePointsView.center.x : self.gameStats.goodPointsView.center.x
            self.answerAnimationLabel.center =  CGPointMake(xOffset,self.gameStats.center.y )
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 1.5, 1.5)
            }, completion: { (value: Bool) in
                self.answerAnimationLabel.transform = CGAffineTransformIdentity
                self.answerAnimationLabel.alpha = 0
                //TODO: perfectscore
                
                if lovePoint
                {
                    self.gameStats.addLovePoints(1)
                    self.datactrl.updateLoveScore(self.currentQuestion, deltaScore:1)
                }
                else
                {
                    self.gameStats.addGoodPoints(points)
                    self.datactrl.updateGoodScore(self.currentQuestion, deltaScore:points)
                }
                
                
                
                self.timelineView.setNeedsDisplay()
                self.timelineView.animateTimelinePocket(self.lastRightPeriodButtonClicked.period, scale:self.timelineScrollView.zoomScale)
                
                completionClosure!()
        })
    }
    
    //MARK: TimelineDelegate
    func finishedAnimatingTimeline()
    {
        self.timelineScrollView.setZoomScale(self.minscaleWidth, animated: true)
    }
    
    
    func continuePlayingWithNewPeriods(periodButton:PeriodButton)
    {
        var tempPeriodItems:[Period] = []
        
        for item in periodButton.period.sortedPeriods
        {
            tempPeriodItems.append(item as! Period)
        }
        
        var yBound =  UIScreen.mainScreen().bounds.size.height / 2
        var xMaxBound:CGFloat = UIScreen.mainScreen().bounds.size.width
        var xMinBound:CGFloat = 0
        
        cleanUpButtons()
        layoutButtons(periodButton,periods: tempPeriodItems,xMinBoundary: xMinBound, xMaxBoundary: xMaxBound,yBoundary: yBound,level: periodButton.level + 1)
    }
    
    func cleanUpButtons()
    {
        for button in buttonCollection
        {
            button.removeFromSuperview()
        }
        buttonCollection = []
    }
    
    func isOnRightTrack(period:Period) -> Bool
    {
        var found = false
        
        for questionPeriod in currentQuestion.periods
        {
            
            found = timelineView.periodHittingPeriod(questionPeriod as? Period, hitting:period)
            
            if(found == true)
            {
                break
            }
            
        }
        
        return found
    }
    
    func backAction()
    {
        //datactrl.saveGameData()
        self.performSegueWithIdentifier("segueFromPlayToMainMenu", sender: nil)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueFromPlayToMainMenu") {
            var svc = segue!.destinationViewController as! MainMenuViewController
            if gameStats.newValues()
            {
                svc.updateGlobalGameStats = true
                svc.newGameStatsValues = (gameStats.okPoints!,gameStats.goodPoints!,gameStats.lovePoints)
                //svc.imagefile = currentImagefile
            }
        }
        
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.bannerView?.hidden = false
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.bannerView?.hidden = true
    }
    
}