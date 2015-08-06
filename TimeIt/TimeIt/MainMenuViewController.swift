//
//  ViewController.swift
//  TimeIt
//
//  Created by knut on 12/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import UIKit
import CoreGraphics
import QuartzCore
import iAd

class MainMenuViewController: UIViewController {//, ADBannerViewDelegate {

    var backgroundView:UIView!
    var playButton:UIButton!
    var playButtonExstraLabel:UILabel!
    var playButtonExstraLabel2:UILabel!
    var timelineButton:UIButton!
    var loadingDataView:UIView!
    var loadingDataLabel:UILabel!
    var datactrl:DataHandler!
    
    let queue = NSOperationQueue()
    
    var globalGameStats:GameStats!
    var updateGlobalGameStats:Bool = false
    var newGameStatsValues:(Int,Int,Int)!

    let levelSlider = RangeSlider(frame: CGRectZero)
    
    
    var bannerView:ADBannerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datactrl = DataHandler()

        self.canDisplayBannerAds = true
        bannerView = ADBannerView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width, 44))
        //bannerView = ADBannerView(frame: CGRectZero)
        self.view.addSubview(bannerView!)
        //self.bannerView?.delegate = self
        self.bannerView?.hidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
        playButton = UIButton(frame:CGRectZero)
        playButton.addTarget(self, action: "playAction", forControlEvents: UIControlEvents.TouchUpInside)
        playButton.backgroundColor = UIColor.blueColor()
        //playButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //playButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        playButtonExstraLabel = UILabel(frame:CGRectZero)
        playButtonExstraLabel.backgroundColor = playButton.backgroundColor?.colorWithAlphaComponent(0)
        playButtonExstraLabel.textColor = UIColor.whiteColor()
        playButtonExstraLabel.font = UIFont.systemFontOfSize(12)
        playButtonExstraLabel.textAlignment = NSTextAlignment.Center
        playButton.addSubview(playButtonExstraLabel)

        playButtonExstraLabel2 = UILabel(frame:CGRectZero)
        playButtonExstraLabel2.backgroundColor = playButton.backgroundColor?.colorWithAlphaComponent(0)
        playButtonExstraLabel2.textColor = UIColor.whiteColor()
        playButtonExstraLabel2.font = UIFont.systemFontOfSize(12)
        playButtonExstraLabel2.textAlignment = NSTextAlignment.Center
        playButton.addSubview(playButtonExstraLabel2)
        
        timelineButton = UIButton(frame:CGRectZero)
        timelineButton.setTitle("Timeline", forState: UIControlState.Normal)
        timelineButton.addTarget(self, action: "timelineAction", forControlEvents: UIControlEvents.TouchUpInside)
        timelineButton.backgroundColor = UIColor.blueColor()
        view.addSubview(timelineButton)
        
        
        levelSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        levelSlider.curvaceousness = 0.0
        levelSlider.maximumValue = Double(maxLevel) + 0.5
        levelSlider.minimumValue = Double(minLevel)
        levelSlider.typeValue = sliderType.bothLowerAndUpper
        view.addSubview(levelSlider)
        
        /*
        let backgroundOperation = BackgroundPopulateData()
        
        queue.addOperation(backgroundOperation)
        //backgroundOperation.threadPriority = 0
        backgroundOperation.completionBlock = {() -> () in
            self.view.addSubview(self.playButton)
            self.loadingDataView.alpha = 0
            self.loadingDataView.layer.removeAllAnimations()
        }*/
        
        /*
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.rangeSlider.trackHighlightTintColor = UIColor.redColor()
            self.rangeSlider.curvaceousness = 0.0
        }
        */

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {

        if Int(datactrl.dataPopulatedID as! NSNumber) <= 0
        {
            loadingDataLabel = UILabel(frame: CGRectMake(0, 0, 200, 50))
            loadingDataLabel.text = "Loading data.."
            loadingDataLabel.textAlignment = NSTextAlignment.Center
            loadingDataView = UIView(frame: CGRectMake(50, 50, 200, 50))
            loadingDataView.backgroundColor = UIColor.redColor()
            loadingDataView.addSubview(loadingDataLabel)
            self.view.addSubview(loadingDataView)
            
            var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
            pulseAnimation.duration = 0.3
            pulseAnimation.toValue = NSNumber(float: 0.3)
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = 100
            pulseAnimation.delegate = self
            loadingDataView.layer.addAnimation(pulseAnimation, forKey: "asd")
            
            DataHandler().populateData({ () in
                self.view.addSubview(self.playButton)
                self.globalGameStats = GameStats(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width * 0.75, UIScreen.mainScreen().bounds.size.height * 0.08),okScore: Int(self.datactrl.okScoreID as! NSNumber),goodScore: Int(self.datactrl.goodScoreID as! NSNumber),loveScore: Int(self.datactrl.loveScoreID as! NSNumber))
                self.view.addSubview(self.globalGameStats)
                self.loadingDataView.alpha = 0
                self.loadingDataView.layer.removeAllAnimations()
            })
            
            loadingDataView?.frame =  CGRectMake(50, 50, 200, 50)
        }
        else
        {
            self.view.addSubview(self.playButton)
            globalGameStats = GameStats(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width * 0.75, UIScreen.mainScreen().bounds.size.height * 0.08),okScore: Int(datactrl.okScoreID as! NSNumber),goodScore: Int(datactrl.goodScoreID as! NSNumber),loveScore: Int(datactrl.loveScoreID as! NSNumber))
            self.view.addSubview(globalGameStats)
        }
        
        if updateGlobalGameStats
        {
            globalGameStats.addOkPoints(newGameStatsValues.0, completion: { () in
                self.globalGameStats.addGoodPoints(self.newGameStatsValues.1, completion: { () in
                    self.globalGameStats.addLovePoints(self.newGameStatsValues.2)
                })
            })
            updateGlobalGameStats = false
            datactrl.updateGameData(newGameStatsValues.0,deltaGoodPoints: newGameStatsValues.1,deltaLovePoints: newGameStatsValues.2)
            datactrl.saveGameData()
        }
    }
    
    
    override func viewDidLayoutSubviews() {

        bannerView?.frame = CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width, 44)
        
        loadingDataView?.frame =  CGRectMake(50, 50, 200, 50)
        let playbuttonWidth = UIScreen.mainScreen().bounds.size.width / 2
        playButton.frame = CGRectMake((UIScreen.mainScreen().bounds.size.width / 2) - (playbuttonWidth / 2), UIScreen.mainScreen().bounds.size.height * 0.15,playbuttonWidth, UIScreen.mainScreen().bounds.size.height / 2)
        //playButton.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 3)
        
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        //rangeSlider.frame = CGRect(x:  margin, y: (UIScreen.mainScreen().bounds.size.height - topLayoutGuide.length) - (margin * 3) ,
        //    width: width, height: 31.0)
        
        
        
        var orientation = UIDevice.currentDevice().orientation
        var orientationText = orientation.isLandscape ? "landscape" : "portrait"
        playButton.setTitle("Play", forState: UIControlState.Normal)
        timelineButton.frame = CGRectMake(playButton.frame.minX, playButton.frame.maxY + (margin / 2), UIScreen.mainScreen().bounds.size.width / 2, playButton.frame.height * 0.25)
        
        if orientation == UIDeviceOrientation.Portrait || orientation == UIDeviceOrientation.PortraitUpsideDown
        {
            
        }
        else
        {
            
        }

        let height:CGFloat = 31.0
        let marginSlider: CGFloat = playButton.frame.minX
        levelSlider.frame = CGRect(x:  marginSlider, y: timelineButton.frame.maxY  + margin, width: UIScreen.mainScreen().bounds.size.width - (marginSlider * 2), height: height)
        
        playButtonExstraLabel.frame = CGRectMake(0, playButton.frame.height * 0.7   , playButton.frame.width, playButton.frame.height * 0.15)
        playButtonExstraLabel.text = "in \(orientationText) mode"
        playButtonExstraLabel2.frame = CGRectMake(0, playButton.frame.height * 0.85   , playButton.frame.width, playButton.frame.height * 0.15)
        playButtonExstraLabel2.text = "level \(Int(levelSlider.lowerValue)) - \(sliderUpperLevelText())"
    }
    
    func sliderUpperLevelText() -> String
    {
        return Int(levelSlider.upperValue) > 3 ? "ridiculous" : "\(Int(levelSlider.upperValue))"
    }
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rangeSliderValueChanged(slider: RangeSlider) {
        //println("Range slider value changed: (\(Int(slider.lowerValue)) \(Int(slider.upperValue)))")
        playButtonExstraLabel2.text = "level \(Int(slider.lowerValue)) - \(sliderUpperLevelText())"
    }
    
    func playAction()
    {
        self.performSegueWithIdentifier("segueFromMainMenuToPlay", sender: nil)
    }
    
    func timelineAction()
    {
        self.performSegueWithIdentifier("segueFromMainMenuToTimeline", sender: nil)
    }
    
    override func prepareForSegue(segue: (UIStoryboardSegue!), sender: AnyObject!) {
        if (segue.identifier == "segueFromMainMenuToPlay") {
            var svc = segue!.destinationViewController as! PlayViewController
            svc.levelLow = Int(levelSlider.lowerValue)
            svc.levelHigh = Int(levelSlider.upperValue)
            svc.tags = "#war#curiosa"
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

