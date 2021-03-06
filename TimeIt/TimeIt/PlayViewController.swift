//
//  PlayViewController.swift
//  TimeIt
//
//  Created by knut on 12/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import UIKit
import iAd

class PlayViewController: UIViewController, UIScrollViewDelegate, TimelineDelegate, ADBannerViewDelegate, ClockProtocol{
    
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
    var answerAnimationYellLabel:UILabel!
    var originalCenterQueston:CGPoint!
    
    let rangeSlider = RangeSlider(frame: CGRectZero)
    let rangeMaxLabel = UILabel()
    let rangeMinLabel = UILabel()
    let rangeButton = UIButton()
    let rangeBaileOutText = "Baile out!"
    var rangeReset = true
    var gametype:gameType!
    var usersIdsToChallenge:[String] = []
    var completedQuestionsIds:[String] = []
    var numOfQuestionsForRound:Int!
    var myIdAndName:(String,String)!
    
    var challenge:Challenge!
    
    let backButton = UIButton()
    var rightPeriodStrikes:Int = 0
    
    var answerButtonReadyForText:Bool = false

    var bannerView:ADBannerView?
    
    var levelHigh:Int = 1
    var levelLow:Int = 1
    var tags:[String] = []
    
    var clock:ClockView!
    var orgClockCenter:CGPoint!
    
    let noBonusSubtractOkPoints:Int = -50
    let bonusPoints10PercentWindow = 75
    let bonusPoints20PercentWindow = 100
    let bonusPointsPerfect = 125
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let adFree = NSUserDefaults.standardUserDefaults().boolForKey("adFree")
        if !adFree
        {
            self.canDisplayBannerAds = true
            bannerView = ADBannerView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.height))
            bannerView!.center = CGPoint(x: bannerView!.center.x, y: self.view.bounds.size.height - bannerView!.frame.size.height / 2)
            self.view.addSubview(bannerView!)
            self.bannerView?.delegate = self
            self.bannerView?.hidden = false
        }
        // Do any additional setup after loading the view, typically from a nib.
        datactrl = (UIApplication.sharedApplication().delegate as! AppDelegate).datactrl
        datactrl.fetchData(tags,fromLevel:levelLow,toLevel: levelHigh)
        datactrl.shuffleEvents()
        datactrl.orderOnUsed()
        
        gameStats = GameStats(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width * 0.5, UIScreen.mainScreen().bounds.size.height * 0.08),okScore: 0,goodScore: 0,loveScore: 0)
        
        //timelineScrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height * 0.20))
        timelineScrollView = UIScrollView(frame: CGRectMake(0, gameStats.frame.maxY, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height * 0.2))
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
        answerAnimationLabel.layer.shadowOpacity = 1.0
        answerAnimationLabel.layer.shadowRadius = 0.7
        answerAnimationLabel.layer.shadowColor = UIColor.blackColor().CGColor
        answerAnimationLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        answerAnimationLabel.alpha = 0
        
        answerAnimationYellLabel = UILabel(frame: CGRectMake(0, 0, rectangleWidth,rectangleHeight))
        answerAnimationYellLabel.font = UIFont.boldSystemFontOfSize(24)
        answerAnimationYellLabel.textAlignment = NSTextAlignment.Center
        answerAnimationYellLabel.numberOfLines = 1;
        answerAnimationYellLabel.adjustsFontSizeToFitWidth = true
        answerAnimationYellLabel.alpha = 0

        if self.gametype == gameType.training
        {
            let backButtonMargin:CGFloat = 15
            backButton.frame = CGRectMake(UIScreen.mainScreen().bounds.size.width - smallButtonSide - backButtonMargin, backButtonMargin, smallButtonSide, smallButtonSide)
            backButton.backgroundColor = UIColor.whiteColor()
            backButton.layer.borderColor = UIColor.grayColor().CGColor
            backButton.layer.borderWidth = 1
            backButton.layer.cornerRadius = 5
            backButton.layer.masksToBounds = true
            backButton.setTitle("🔚", forState: UIControlState.Normal)
            backButton.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)
            view.addSubview(backButton)
        }

        let margin: CGFloat = 10.0
        questionLabel = UILabel(frame: CGRectMake(margin, timelineScrollView.frame.maxY + (UIScreen.mainScreen().bounds.height * 0.07), UIScreen.mainScreen().bounds.width - (margin * 2), 50))
        questionLabel.textAlignment = NSTextAlignment.Center
        questionLabel.font = UIFont.boldSystemFontOfSize(25)
        questionLabel.numberOfLines = 1
        questionLabel.adjustsFontSizeToFitWidth = true
        questionLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        questionLabel.lineBreakMode = NSLineBreakMode.ByClipping //NSLineBreakMode.ByWordWrapping
        originalCenterQueston = questionLabel.center
        //originalCenterQueston = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height * 0.15)
        //questionLabel.center = originalCenterQueston
        
        clock = ClockView(frame: CGRectMake(0, 0, gameStats.frame.height * 1.2, gameStats.frame.height * 1.2))
        orgClockCenter = CGPointMake(10 + gameStats.frame.maxX + (self.clock.frame.width / 2),10 + (self.clock.frame.height / 2))
        clock.center = orgClockCenter
        clock.delegate = self

        
        view.addSubview(questionLabel)
        view.addSubview(timelineScrollView)
        view.addSubview(gameStats)
        view.addSubview(answerAnimationLabel)
        view.addSubview(answerAnimationYellLabel)
        view.addSubview(backButton)
        view.addSubview(clock)

        startPlay()
    }
    
    override func viewWillDisappear(animated: Bool) {
        bannerView?.delegate = nil
        bannerView?.removeFromSuperview()
    }
    
    override func viewDidAppear(animated: Bool) {

        bannerView?.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height)
        bannerView!.center = CGPoint(x: bannerView!.center.x, y: self.view.bounds.size.height - bannerView!.frame.size.height / 2)
        
        let bottomOffset = CGPointMake(0, self.timelineScrollView.contentSize.height - self.timelineScrollView.bounds.size.height)
        timelineScrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    /*
    override func viewWillAppear(animated: Bool) {
        bannerView?.translatesAutoresizingMaskIntoConstraints = false
        
        bannerView?.frame = CGRectZero
        bannerView!.center = CGPoint(x: bannerView!.center.x, y: self.view.bounds.size.height - bannerView!.frame.size.height / 2)
    }
    */
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        
        
        let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
        let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
        
        timelineView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
            scrollView.contentSize.height * 0.5 + offsetY);
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return timelineView
    }
    
    func timeup()
    {
        print("timeup")
        
        for item in self.buttonCollection
        {
            item.userInteractionEnabled = false
            /*
            if !self.buttonInButtonHirarcy(item,buttonHirarcy: sender)
            {
                item.alpha = 0
            }
            */
        }
        animateTimeup()
    
        
    }
    
    func animateTimeup()
    {
        //_? is this ok
        view.bringSubviewToFront(clock)
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.clock.center = CGPointMake(UIScreen.mainScreen().bounds.width / 2, UIScreen.mainScreen().bounds.height / 2)
            self.clock.transform = CGAffineTransformScale(self.clock.transform, 3, 3)
            
            }, completion: { (value: Bool) in
                let label = UILabel(frame: CGRectMake(0, 0, 100, 40))
                label.textAlignment = NSTextAlignment.Center
                label.font = UIFont.boldSystemFontOfSize(20)
                label.adjustsFontSizeToFitWidth = true
                label.backgroundColor = UIColor.clearColor()
                label.text = "Time is up"
                label.alpha = 1
                label.center = self.clock.center
                label.transform = CGAffineTransformScale(label.transform, 0.1, 0.1)
                self.view.addSubview(label)
                
                UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.clock.transform = CGAffineTransformScale(self.clock.transform, 7, 7)
                    
                    label.transform = CGAffineTransformIdentity
                    label.transform = CGAffineTransformScale(label.transform, 3, 3)
                    
                    }, completion: { (value: Bool) in
                        
                        UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            
                            self.clock.alpha = 0
                            label.alpha = 0
                            
                            }, completion: { (value: Bool) in
                                label.removeFromSuperview()
                                
                                //animate showing answer and give some minuspoints
                                self.animateTimeupMinusPoints()
                                
                        })
                })
        })
    }
    
    func animateTimeupMinusPoints()
    {

        let button = {() -> UIButton? in
            for item in self.buttonCollection
            {
                if self.isOnRightTrack(item.period)
                {
                    return item
                }
            }
            return self.rangeButton
        }()
        
        let yearlabel = UILabel(frame: CGRectMake(0, 0, 100, 40))
        yearlabel.textAlignment = NSTextAlignment.Center
        yearlabel.font = UIFont.boldSystemFontOfSize(20)
        yearlabel.adjustsFontSizeToFitWidth = true
        yearlabel.backgroundColor = UIColor.clearColor()
        yearlabel.text = "\(self.currentQuestion.formattedTime)😕"
        yearlabel.center = questionLabel.center //button!.center
        yearlabel.transform = CGAffineTransformScale(yearlabel.transform, 0.1, 0.1)
        self.view.addSubview(yearlabel)
        
        let minusPoints = 3
        let minusPointslabel = UILabel(frame: CGRectMake(0, 0, 60, 40))
        minusPointslabel.textAlignment = NSTextAlignment.Center
        minusPointslabel.font = UIFont.boldSystemFontOfSize(20)
        minusPointslabel.backgroundColor = UIColor.clearColor()
        minusPointslabel.text = "-\(minusPoints)"
        minusPointslabel.center = questionLabel.center //button!.center
        minusPointslabel.transform = CGAffineTransformScale(minusPointslabel.transform, 0.1, 0.1)
        self.view.addSubview(minusPointslabel)
        
        if let item = button
        {
            if self.rangeButton !=  item
            {
                let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
                pulseAnimation.duration = 0.3
                pulseAnimation.toValue = NSNumber(float: 0.3)
                pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                pulseAnimation.autoreverses = true;
                pulseAnimation.repeatCount = 5
                pulseAnimation.delegate = self
                item.layer.addAnimation(pulseAnimation, forKey: "minusPointsAnimation")
            }
        }
        UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            //button?.transform = CGAffineTransformScale(button!.transform, 2, 2)

            yearlabel.transform = CGAffineTransformIdentity
            yearlabel.transform = CGAffineTransformScale(yearlabel.transform, 2, 2)
            yearlabel.frame.offsetInPlace(dx: 0, dy: button!.frame.height * -1)
            
            minusPointslabel.transform = CGAffineTransformIdentity
            minusPointslabel.center = self.gameStats.okPointsView.center
           
            }, completion: { (value: Bool) in
                self.gameStats.subtractOkPoints(minusPoints)
                UIView.animateWithDuration(1, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    yearlabel.transform = CGAffineTransformIdentity
                    yearlabel.alpha = 0
                    minusPointslabel.alpha = 0
                    
                    }, completion: { (value: Bool) in
                        button?.layer.removeAllAnimations()
                        yearlabel.removeFromSuperview()
                        minusPointslabel.removeFromSuperview()
                        self.resetRange()
                        self.setNextQuestion()
                })

        })
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
                //println(" test formattedUpperValue \(rangeSlider.formattedUpperValue)")
                rangeMaxLabel.text = rangeSlider.formattedUpperValue //"\(Int(rangeSlider.upperValue))"
            }
        }
        
        //print("Range slider value changed: (\(Int(rangeSlider.lowerValue)) \(Int(rangeSlider.upperValue)))")
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
        rangeSlider.resetWindows()
        //rangeSlider.setNeedsDisplay()
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
        rangeSlider.setNeedsDisplay()

    }
    
    func setAlphaOnRangeItems(value:CGFloat)
    {
        rangeMinLabel.alpha = value
        rangeMaxLabel.alpha = value
        rangeButton.alpha = value
        rangeSlider.alpha = value
    }
    
    
    func setNextQuestion()
    {
        if let c = clock
        {
            c.stop()
        }
        

        if (self.gametype == gameType.makingChallenge) && (self.completedQuestionsIds.count  >= self.numOfQuestionsForRound)
        {
            self.performSegueWithIdentifier("segueFromPlayToFinished", sender: nil)
        }
        else if gametype == gameType.takingChallenge
        {
            //randomHistoricEvents = datactrl.fetchHistoricEventOnIds(challenge.getNextQuestionBlock())!
            if let questionId = challenge.getNextQuestionId()
            {
                currentQuestion = datactrl.fetchHistoricEventOnId(questionId)!
                animateQuestion()
            }
            else
            {
                self.performSegueWithIdentifier("segueFromPlayToFinished", sender: nil)
            }
        }
        else //makingChallenge or training
        {
            currentQuestion = datactrl.historicEventItems[index % datactrl.historicEventItems.count]
            animateQuestion()
        }
    }
    
    func animateQuestion()
    {
        currentQuestion.used++
        datactrl.save()
        self.completedQuestionsIds.append("\(currentQuestion.idForUpdate)")
        
        UIView.animateWithDuration(0.50, animations: { () -> Void in
            self.questionLabel.center = CGPointMake(0 - self.questionLabel.frame.width, self.originalCenterQueston.y)
            
            }, completion: { (value: Bool) in
                self.questionLabel.center = CGPointMake(UIScreen.mainScreen().bounds.width + self.questionLabel.frame.width, self.originalCenterQueston.y)
                self.questionLabel.text = self.currentQuestion.title
                
                UIView.animateWithDuration(0.50, animations: { () -> Void in
                    self.questionLabel.center = self.originalCenterQueston
                    
                    }, completion: { (value: Bool) in
                        self.questionLabel.center = self.originalCenterQueston
                        self.index++
                        self.loadQuestion()
                        
                        if let c = self.clock
                        {
                            c.transform = CGAffineTransformIdentity
                            c.center = self.orgClockCenter
                            c.alpha = 1
                            c.start(10.0)
                        }
                })
        })
    }
    
    func loadQuestion()
    {
        let readyToLayout: ([Period]) -> () = { (periods) -> () in
            
            if( periods.count > 0)
            {
                let xMaxBound:CGFloat = UIScreen.mainScreen().bounds.size.width
                let xMinBound:CGFloat = 0
                let yBoundary = self.questionLabel.frame.maxY + (UIScreen.mainScreen().bounds.size.height * 0.07)
                self.cleanUpButtons()
                self.layoutButtons(nil,periods: periods, xMinBoundary: xMinBound, xMaxBoundary: xMaxBound,yBoundary: yBoundary, level: 1)
            }
        }
        var periodItemsOnTypeAndLevelDepth:[Period] = []

        
        if rightPeriodStrikes >= 3
        {
            let periodsOneLevelFromEvent = ((currentQuestion.periods.allObjects as! [Period])[0] as Period).period?.sortedPeriods
            if periodsOneLevelFromEvent == nil
            {
                print("Could not get periods one level up for question \(currentQuestion.title)")
                rightPeriodStrikes -= 2
                self.loadQuestion()
            }
            else
            {
                //show from 1000 year periods
                for item in periodsOneLevelFromEvent!
                {
                    periodItemsOnTypeAndLevelDepth.append(item as! Period)
                }
                readyToLayout(periodItemsOnTypeAndLevelDepth)
            }
        }
        else if rightPeriodStrikes >= 1
        {
            let periodsToLevelsFromEvent = ((currentQuestion.periods.allObjects as! [Period])[0] as Period).period?.period?.sortedPeriods
            if periodsToLevelsFromEvent == nil
            {
                print("Could not get periods to levels up for question \(currentQuestion.title)")
                rightPeriodStrikes = 0
                self.loadQuestion()
            }
            else
            {
                //show from 1000 year periods
                for item in periodsToLevelsFromEvent!
                {
                    periodItemsOnTypeAndLevelDepth.append(item as! Period)
                }
                readyToLayout(periodItemsOnTypeAndLevelDepth)
            }
        }
        else
        {
            //show only to levels up from event
            for item in datactrl.periodsItems
            {
                if item.type == Int16(periodType.millenia.rawValue)
                {
                    periodItemsOnTypeAndLevelDepth.append(item)
                }
            }
            readyToLayout(periodItemsOnTypeAndLevelDepth)
        }
       
        if let adview = bannerView
        {
            view.bringSubviewToFront(adview)
        }

    }
    
    let defaultButtonHeight:CGFloat = 70
    func layoutButtons(parentButton:PeriodButton?, periods:[Period],xMinBoundary:CGFloat, xMaxBoundary:CGFloat, yBoundary:CGFloat, buttonHeight:CGFloat = 70,level:Int, layoutDepth: Int = 0)
    {
        let vertialHorizontalMargin:CGFloat = 2
        let buttonWidth = (xMaxBoundary - xMinBoundary - (vertialHorizontalMargin * (CGFloat(periods.count) - 1))) / CGFloat(periods.count)
        var x:CGFloat = xMinBoundary
        var collectionForRelation:[PeriodButton] = []
        for item in periods
        {
            if layoutDepth < 2
            {
                let periodButton = PeriodButton(frame:CGRectMake(0, 0, buttonWidth,buttonHeight), level:level, period: item as Period)
                periodButton.addTarget(self, action: "periodSelected:", forControlEvents: .TouchUpInside)

                buttonCollection.append(periodButton)
                collectionForRelation.append(periodButton)
                periodButton.center = CGPointMake(x + (periodButton.frame.width/2), yBoundary + (periodButton.frame.height / 2))
                
                    if periodButton.frame.size.width < (UIScreen.mainScreen().bounds.size.width / 4)
                    {
                        periodButton.titleLabel?.font = UIFont.systemFontOfSize(10)
                    }
                    if buttonHeight < CGFloat(70)
                    {
                        periodButton.enabled = false
                        periodButton.backgroundColor = UIColor.lightGrayColor()
                    }


                //periodButton.transform = CGAffineTransformScale(periodButton.transform, 0.1, 0.1)
                if layoutDepth > 0
                {
                    periodButton.alpha = 0
                }
                self.view.addSubview(periodButton)
                    


                var tempPeriodItemsOnType:[Period] = []
                for item in item.sortedPeriods
                {
                    tempPeriodItemsOnType.append(item as! Period)
                }

                let newYBoundary = yBoundary + periodButton.frame.size.height + vertialHorizontalMargin

                    layoutButtons(periodButton,periods: tempPeriodItemsOnType, xMinBoundary: x, xMaxBoundary: x + periodButton.frame.size.width, yBoundary: newYBoundary, buttonHeight: buttonHeight / 2 , level: level + 1, layoutDepth: layoutDepth + 1)
               
                x += periodButton.frame.width + vertialHorizontalMargin
                if layoutDepth > 0
                {
                    periodButton.transform = CGAffineTransformScale(periodButton.transform, 0.1, 0.1)
                }
            }
        }
        
        if parentButton != nil
        {
            parentButton!.childButtons = collectionForRelation
        }
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            for item in collectionForRelation
            {
                item.alpha = 1
                item.transform = CGAffineTransformIdentity
            }
            
            })
     
    }
    
    func periodSelected(sender: PeriodButton)
    {
        //self.clock.restart(10.0)
        //self.clock.alpha = 1
        
        //animate!!!
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
            //sender.layoutIfNeeded() ?? ()
            var x:CGFloat = 0
            let vertialHorizontalMargin:CGFloat = 2
            let buttonWidth = (UIScreen.mainScreen().bounds.size.width - (vertialHorizontalMargin * (CGFloat(sender.childButtons.count) - 1))) / CGFloat(sender.childButtons.count)
            //var buttonWidth = UIScreen.mainScreen().bounds.size.width / CGFloat(sender.childButtons.count)
            for item in sender.childButtons
            {
                
                item.frame = CGRectMake(0,0, buttonWidth, self.defaultButtonHeight)
                item.insideLabel.center = item.center
                item.backgroundColor = UIColor.greenColor()
                item.center = CGPointMake(x + (item.frame.width/2), self.questionLabel.frame.maxY +  (item.frame.height / 2))
                
                x += item.frame.width + vertialHorizontalMargin
            }
            
            }, completion: { (value: Bool) in
                

                
            //animate button desolvement
            UIView.animateWithDuration(0.25, animations: { () -> Void in

                //test
                for item in sender.childButtons
                {
                    
                    item.insideLabel.alpha = 1
                }
                //end test
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
            
            self.shrinkAndHideClock()
            self.clock.stop()
            //self.clock.alpha = 1
            //self.clock.restart(10.0)
            rightAnswerGiven(sender)
        }
        else
        {
            let rightTrack = isOnRightTrack(sender.period)
            if rightTrack
            {
                self.clock.alpha = 1
                self.clock.restart(10.0)
                givePointsForRightPath(sender)
                continuePlayingWithNewPeriods(sender)
            }
            else
            {
                self.shrinkAndHideClock()
                self.clock.stop()
                wrongAnswerGiven(sender)
            }
        }
    }
    
    func shrinkAndHideClock()
    {
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            
            self.clock.alpha = 0
            self.clock.transform = CGAffineTransformScale(self.clock.transform, 0.1, 0.1)
            
            }, completion: { (value: Bool) in
                
                self.clock.transform = CGAffineTransformIdentity
        })
    }
    
    func givePointsForRightPath(periodButton:PeriodButton)
    {
        animateRightPeriod(periodButton)
    }
    
    var lastRightPeriodButtonClicked:PeriodButton!
    func rightAnswerGiven(periodButton:PeriodButton)
    {
        lastRightPeriodButtonClicked = periodButton
        rightPeriodStrikes =  rightPeriodStrikes >= 3 ? 3 : rightPeriodStrikes + 1
        
        animateRightPeriod(periodButton, completion: {() -> Void in
                self.bonusQuestion(periodButton)
            
        })
    }
    
    func animateRightPeriod(periodButton:PeriodButton,completion: (() -> (Void))? = nil)
    {
        let points = periodButton.level * 10
        answerAnimationLabel.textColor = UIColor.greenColor()
        view.bringSubviewToFront(answerAnimationLabel)
        answerAnimationLabel.center = periodButton.center
        answerAnimationLabel.text = "\(points)"
        self.answerAnimationLabel.alpha = 0

        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            periodButton.alpha = 0
            self.answerAnimationLabel.alpha = 1
            
            }, completion: { (value: Bool) in
                
                UIView.animateWithDuration(1.0, delay: 0.0, options:UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                    //self.answerAnimationLabel.center = self.gameStats.okPointsView.center
                    
                    self.answerAnimationLabel.center = self.gameStats.okPointsView.center
                    self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 1.2, 1.2)
                    }, completion: { (value: Bool) in
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            
                            self.answerAnimationLabel.alpha = 0
                            
                            }, completion: { (value: Bool) in
                                
                                self.answerAnimationLabel.transform = CGAffineTransformIdentity
                                self.gameStats.addOkPoints(points)
                                self.datactrl.updateOkScore(self.currentQuestion, deltaScore:points)
                                self.answerAnimationLabel.alpha = 0
                                completion?()
                        })
                })
        })


    }
    
    func wrongAnswerGiven(periodButton:PeriodButton)
    {
        let points = periodButton.level * 3
        rightPeriodStrikes = rightPeriodStrikes <= 0 ? 0 : rightPeriodStrikes - 1
        answerAnimationLabel.textColor = UIColor.redColor()
        answerAnimationLabel.center = periodButton.center
        self.view.bringSubviewToFront(answerAnimationLabel)
        answerAnimationLabel.text = "😫 \(currentQuestion.formattedTime)"
        answerAnimationLabel.alpha = 1
        //animate zoominrect
        UIView.animateWithDuration(1.0, delay: 0.0, options:UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            for button:PeriodButton in self.buttonCollection
            {
                button.alpha = 0
            }
            let scale = UIScreen.mainScreen().bounds.size.width / self.answerAnimationLabel.frame.width
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, scale, scale)
            //self.answerAnimationLabel.center = CGPointMake(self.answerAnimationLabel.center.x, self.answerAnimationLabel.center.y - self.answerAnimationLabel.frame.height )
            self.answerAnimationLabel.center = CGPointMake(self.answerAnimationLabel.center.x, self.answerAnimationLabel.frame.height / 2)
            }, completion: { (value: Bool) in

                UIView.animateWithDuration(1.0, delay: 0.0, options:UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 0.5, 0.5)
                    self.answerAnimationLabel.alpha = 0
                    } , completion: { (value: Bool) in
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
        self.clock.alpha = 1
        self.clock.start(10)
        rangeSlider.maximumValue = datactrl.getMaxTimeLimit(Double(periodButton.period.toYear))
        rangeSlider.minimumValue = Double(periodButton.period.fromYear)

        print("rangeslider max \(rangeSlider.maximumValue) min \(rangeSlider.minimumValue)")
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
        self.rangeSlider.setNeedsDisplay()

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
        clock.alpha = 0
        clock.stop()
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
                        self.gameStats.subtractOkPoints(self.noBonusSubtractOkPoints)
                        //self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
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
                        self.gameStats.subtractOkPoints(self.noBonusSubtractOkPoints)
                        //self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: 1)
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
                        self.gameStats.subtractOkPoints(self.noBonusSubtractOkPoints)
                        //self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
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
                            self.gameStats.subtractOkPoints(self.noBonusSubtractOkPoints)
                            //self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
                            self.resetRange()
                            self.setNextQuestion()
                        })
                    })
                    
                }
                else if selectedBits == 2
                {
                    giveNoBonus(rangeMinLabel, completionClosure: { () in
                        self.gameStats.subtractOkPoints(self.noBonusSubtractOkPoints)
                        //self.datactrl.updateGoodScore(self.currentQuestion, deltaScore: -1)
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
                        self.gameStats.subtractOkPoints(self.noBonusSubtractOkPoints * 2)
                        self.resetRange()
                        self.setNextQuestion()
                    })
                }

            }
        }
    }
    
    func valueWithinRange(valueGiven:Int,questionValue:Int) -> Int
    {
        let withinUpper10 = valueGiven <= Int(questionValue + lastRightPeriodButtonClicked.period.lowPercentHalfWindow())
        let withinLower10 = valueGiven >= (Int(questionValue - lastRightPeriodButtonClicked.period.lowPercentHalfWindow()))
        //println("valueGiven\(valueGiven) questionValue \(questionValue)")
        //println("upper10 \(Int(CGFloat(questionValue) * 1.1)) lower10 \(Int(CGFloat(questionValue) * 0.9))")
        
        let withinUpper20 = valueGiven <= (Int(questionValue + lastRightPeriodButtonClicked.period.highPercentHalfWindow()))
        let withinLower20 = valueGiven >= (Int(questionValue + lastRightPeriodButtonClicked.period.lowPercentHalfWindow()))
        if valueGiven == questionValue
        {
            return bonusPointsPerfect
        }
        else if withinUpper10 && withinLower10
        {
            return bonusPoints10PercentWindow
        }
        else if withinLower20 && withinUpper20
        {
            return bonusPoints20PercentWindow
        }
        else
        {
            return noBonusSubtractOkPoints
        }
    }
    

    func giveNoBonus(animateFromView:UIView ,completionClosure: (() -> (Void))? )
    {

        if animateFromView == rangeMinLabel
        {
            rangeSlider.higlightLowerWindow(currentQuestion.fromYear)
        }
        else if animateFromView == rangeMaxLabel
        {
            rangeSlider.higlightUpperWindow(currentQuestion.toYear)
        }
        else
        {
            rangeSlider.higlightWindows((currentQuestion.fromYear,currentQuestion.toYear))
            //rangeSlider.higlightUpperWindow(currentQuestion.toYear)
            //rangeSlider.higlightLowerWindow(currentQuestion.fromYear)
        }
        
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
            let scale = UIScreen.mainScreen().bounds.size.width / self.answerAnimationLabel.frame.width
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, scale, scale)
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


            let xPos = self.timelineView.getXPosOfTimelineItem(lastRightPeriodButtonClicked.period)
            let yPosForceBottomOfScroll:CGFloat = 9999
            self.timelineScrollView.zoomToRect(CGRectMake(xPos - rectangleWidth, yPosForceBottomOfScroll , rectangleWidth * 3, self.timelineScrollView.frame.height), animated: true)
            self.timelineView.animateTimelinePocket(lastRightPeriodButtonClicked.period, scale:self.timelineScrollView.zoomScale)
            
        
        
        let lovePoint = points == self.bonusPointsPerfect
        let percentString:String = {() -> String in
            if points == self.bonusPoints20PercentWindow
            {
                return "\(Int(highPercentWindow * 100))% window"
            }
            else if points == self.bonusPoints10PercentWindow
            {
                return "\(Int(lowPercentWindow * 100))% window"
            }
            else if points == self.bonusPointsPerfect
            {
                return "Perfect"
            }
            
            return ""
        }()
        
        let pointsStringOkPoints = {() -> String in
            if points == self.bonusPoints20PercentWindow
            {
                return "\(self.bonusPoints20PercentWindow)"
            }
            else if points == self.bonusPoints10PercentWindow
            {
                return "\(self.bonusPoints10PercentWindow)"
            }
            else if points == self.bonusPointsPerfect
            {
                return "\(self.bonusPointsPerfect)"
            }
            return ""
        }()
        
        if animateFromView == rangeMinLabel
        {
            rangeSlider.higlightLowerWindow(currentQuestion.fromYear)
        }
        else if animateFromView == rangeMaxLabel
        {
            rangeSlider.higlightUpperWindow(currentQuestion.toYear)
        }
        else
        {
            rangeSlider.higlightWindows((currentQuestion.fromYear,currentQuestion.toYear))
            //rangeSlider.higlightLowerWindow(currentQuestion.fromYear)
            //rangeSlider.higlightUpperWindow(currentQuestion.toYear)
        }

        
        answerAnimationLabel.textColor = UIColor.greenColor()
        self.view.bringSubviewToFront(answerAnimationLabel)
        answerAnimationLabel.center = animateFromView.center //CGPointMake(animateFromView.frame.maxX, animateFromView.frame.maxY)
        answerAnimationLabel.text = pointsStringOkPoints
        answerAnimationLabel.alpha = 0
        
        let lovepointAnimationLabel:UILabel? = lovePoint ? UILabel(frame: answerAnimationLabel.frame) : nil
        lovepointAnimationLabel?.center = animateFromView.center
        lovepointAnimationLabel?.text = "1"
        lovepointAnimationLabel?.textColor = UIColor.greenColor()
        lovepointAnimationLabel?.textAlignment = NSTextAlignment.Center
        lovepointAnimationLabel?.alpha = 0
        if let label = lovepointAnimationLabel
        {
            self.view.addSubview(label)
        }
        
        
        answerAnimationYellLabel.textColor = UIColor.blackColor()
        self.view.bringSubviewToFront(answerAnimationYellLabel)
        answerAnimationYellLabel.center = animateFromView.center //CGPointMake(animateFromView.frame.maxX, animateFromView.frame.maxY)
        answerAnimationYellLabel.text = percentString
        answerAnimationYellLabel.transform = CGAffineTransformScale(self.answerAnimationYellLabel.transform, 0.1, 0.1)
        //animate zoominrect
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            let xPos = self.timelineView.getXPosOfTimelineItem(self.lastRightPeriodButtonClicked.period)
            let yPosForceBottomOfScroll:CGFloat = 9999 //self.timelineScrollView.contentOffset.y + self.timelineScrollView.frame.height
            self.timelineScrollView.zoomToRect(CGRectMake(xPos - rectangleWidth, yPosForceBottomOfScroll , rectangleWidth * 3, self.timelineScrollView.frame.height), animated: true)
            let xOffsetOkPoint = self.gameStats.okPointsView.center.x
            self.answerAnimationLabel.center =  CGPointMake(xOffsetOkPoint,self.gameStats.center.y )
            self.answerAnimationLabel.alpha = 1
            self.answerAnimationLabel.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 1.5, 1.5)
            

            
            
            self.answerAnimationYellLabel.center =  CGPointMake(UIScreen.mainScreen().bounds.width / 2,self.answerAnimationYellLabel.center.y )
            self.answerAnimationYellLabel.transform = CGAffineTransformIdentity
            self.answerAnimationYellLabel.alpha = 1
            self.answerAnimationYellLabel.transform = CGAffineTransformScale(self.answerAnimationYellLabel.transform, 1.5, 1.5)
            
            }, completion: { (value: Bool) in
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.answerAnimationLabel.alpha = 0
                    self.answerAnimationYellLabel.alpha = 0
                    lovepointAnimationLabel?.alpha = 0
                    }, completion: { (value: Bool) in
                        self.answerAnimationYellLabel.alpha = 0
                        self.answerAnimationLabel.transform = CGAffineTransformIdentity
                        self.answerAnimationLabel.alpha = 0
                        
                        self.answerAnimationYellLabel.transform = CGAffineTransformIdentity
                        self.answerAnimationYellLabel.alpha = 0
                        
                        self.gameStats.addOkPoints(points)
                        self.datactrl.updateOkScore(self.currentQuestion, deltaScore:points)
                        
                        
                        if lovePoint
                        {
                            
                            UIView.animateWithDuration(0.5, animations: { () -> Void in
                                    let xOffsetLovepoint = self.gameStats.lovePointsView.center.x
                                    lovepointAnimationLabel?.center =  CGPointMake(xOffsetLovepoint,self.gameStats.center.y )
                                    lovepointAnimationLabel?.alpha = 1
                                    lovepointAnimationLabel?.transform = CGAffineTransformScale(self.answerAnimationLabel.transform, 1.5, 1.5)
                                
                                }, completion: { (value: Bool) in
                                    
                                    lovepointAnimationLabel?.removeFromSuperview()
                                    self.gameStats.addLovePoints(1)
                                    self.datactrl.updateLoveScore(self.currentQuestion, deltaScore:1)

                                    self.timelineView.setNeedsDisplay()
                                    self.timelineView.animateTimelinePocket(self.lastRightPeriodButtonClicked.period, scale:self.timelineScrollView.zoomScale)
                                    completionClosure!()
                            })
                        }
                        else
                        {
                            self.timelineView.setNeedsDisplay()
                            self.timelineView.animateTimelinePocket(self.lastRightPeriodButtonClicked.period, scale:self.timelineScrollView.zoomScale)
                            completionClosure!()
                        }
                        
                        
                        
                })
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
        
        let yBound =  questionLabel.frame.maxY + (UIScreen.mainScreen().bounds.size.height * 0.07)
        let xMaxBound:CGFloat = UIScreen.mainScreen().bounds.size.width - 0
        let xMinBound:CGFloat = 0
        
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
        self.clock.stop()
        self.clock.delegate = nil
        self.clock = nil
        //datactrl.saveGameData()
        self.performSegueWithIdentifier("segueFromPlayToMainMenu", sender: nil)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueFromPlayToMainMenu") {
            let svc = segue!.destinationViewController as! MainMenuViewController
            if gameStats.newValues()
            {
                svc.updateGlobalGameStats = true
                svc.newGameStatsValues = (gameStats.okPoints!,gameStats.goodPoints!,gameStats.lovePoints)
                //svc.imagefile = currentImagefile
            }
        }
        if (segue.identifier == "segueFromPlayToFinished") {
            let svc = segue!.destinationViewController as! FinishedViewController
            svc.completedQuestionsIds = completedQuestionsIds
            svc.usersIdsToChallenge = usersIdsToChallenge
            svc.userFbId = myIdAndName.0
            svc.correctAnswers = gameStats.lovePoints
            svc.points = gameStats.okPoints
            svc.gametype = gametype
            if gametype == gameType.takingChallenge
            {
                svc.challengeToBeat = challenge
            }
            else if gametype == gameType.makingChallenge
            {
                svc.challengeName = "\(self.myIdAndName.1) \(self.levelLow)-\(self.levelHigh) \(self.tagsAsString())"
            }
        }
        
    }
    
    func tagsAsString() -> String
    {
        var result = ""
        for item in tags
        {
            result += item
        }
        if result == ""
        {
            result = "All categories"
        }
        return result
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        let adFree = NSUserDefaults.standardUserDefaults().boolForKey("adFree")
        self.bannerView?.hidden = adFree
    }
    
    func bannerViewActionShouldBegin(banner: ADBannerView!, willLeaveApplication willLeave: Bool) -> Bool {
        return willLeave
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        let adFree = NSUserDefaults.standardUserDefaults().boolForKey("adFree")
        self.bannerView?.hidden = adFree
    }
    
}