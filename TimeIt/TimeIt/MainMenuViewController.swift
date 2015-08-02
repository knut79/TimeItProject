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

class MainMenuViewController: UIViewController, ADBannerViewDelegate {

    var backgroundView:UIView!
    var playButton:UIButton!
    var playButtonExstraLabel:UILabel!
    var timelineButton:UIButton!
    var loadingDataView:UIView!
    var loadingDataLabel:UILabel!
    var datactrl:DataHandler!
    
    let queue = NSOperationQueue()
    
    var globalGameStats:GameStats!
    var updateGlobalGameStats:Bool = false
    var newGameStatsValues:(Int,Int,Int)!

    //let rangeSlider = RangeSlider(frame: CGRectZero)
    
    
    var bannerView:ADBannerView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datactrl = DataHandler()

        self.canDisplayBannerAds = true
        bannerView = ADBannerView(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 44, UIScreen.mainScreen().bounds.size.width, 44))
        //bannerView = ADBannerView(frame: CGRectZero)
        self.view.addSubview(bannerView!)
        self.bannerView?.delegate = self
        self.bannerView?.hidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
        playButton = UIButton(frame:CGRectZero)
        playButton.addTarget(self, action: "playAction", forControlEvents: UIControlEvents.TouchUpInside)
        playButton.backgroundColor = UIColor.blueColor()
        //playButton.titleLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        //playButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        playButtonExstraLabel = UILabel(frame:CGRectZero)

        playButtonExstraLabel.backgroundColor = playButton.backgroundColor
        playButtonExstraLabel.textColor = UIColor.whiteColor()
        playButtonExstraLabel.font = UIFont.systemFontOfSize(12)
        playButtonExstraLabel.textAlignment = NSTextAlignment.Center
        playButton.addSubview(playButtonExstraLabel)
        
        timelineButton = UIButton(frame:CGRectZero)
        timelineButton.setTitle("Timeline", forState: UIControlState.Normal)
        timelineButton.addTarget(self, action: "timelineAction", forControlEvents: UIControlEvents.TouchUpInside)
        timelineButton.backgroundColor = UIColor.blueColor()
        view.addSubview(timelineButton)
        
        /*
        rangeSlider.addTarget(self, action: "rangeSliderValueChanged:", forControlEvents: .ValueChanged)
        
        rangeSlider.maximumValue = 1850
        rangeSlider.minimumValue = 1800
        rangeSlider.typeValue = sliderType.justUpper
        self.rangeSlider.curvaceousness = 0.0
        view.addSubview(rangeSlider)
        
        rangeSlider.maximumValue = 2000
        rangeSlider.minimumValue = 1950
        rangeSlider.typeValue = sliderType.bothLowerAndUpper
        */
        
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
        //test
        /*
        giveNoBonus(){ (value:Bool) in
            println("outside 2")
        }
        
        hardProcessingWithString("commands") {
            (result: String) in
            //println("got back: \(result)")
            println("got back")
        }
        */
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if Int(datactrl.dataPopulatedID as! NSNumber) == 0
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
            
            populateData({ () in
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
            que(){ () in
                println("outside 2")
            }
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
        
        playButton.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2)
        playButton.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 3)
        
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

        
        playButtonExstraLabel.frame = CGRectMake(0, (playButton.frame.height / 2) + (playButton.frame.height / 6)  , playButton.frame.width, playButton.frame.height / 3)
        playButtonExstraLabel.text = "in \(orientationText) mode"
    }
    
    func populateData(completionClosure: (() -> (Void))?)
    {
        DataHandler().populateData()
        completionClosure!()
    }
    
    //test
    
    
    func hardProcessingWithString(input: String, completion: (result: String) -> Void) {
            //completion(result: "we finished!")
        println("we finished!")
        completion(result: "we finished!")
    }
    
    func giveNoBonus(completionClosure: ((Bool) -> (Void))?)
    {
        println("inside 2")
        completionClosure!(true)
        //giveNoBonus(animateFromView,lastInChain: false)
        
    }
    
    func que(completion: (() -> (Void))?)
    {
        completion!()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func rangeSliderValueChanged(rangeSlider: RangeSlider) {
        println("Range slider value changed: (\(Int(rangeSlider.lowerValue)) \(Int(rangeSlider.upperValue)))")
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
            //var svc = segue!.destinationViewController as! FilepointListViewController
            //svc.imagefile = currentImagefile
            
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

