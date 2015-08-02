//
//  GameStats.swift
//  TimeIt
//
//  Created by knut on 19/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import UIKit

class GameStats:UIView {
    
    var okPointsView:UIView!
    var okPoints:Int!
    var okPointsLabel:UILabel!
    var goodPointsView:UIView!
    var goodPoints:Int!
    var goodPointsLabel:UILabel!
    var lovePointsView:UIView!
    var lovePoints:Int!
    var lovePointsLabel:UILabel!
    
    var animationLabel:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        okPoints = 0
        goodPoints = 0
        lovePoints = 0
        let marginLeft:CGFloat = 10
        let marginTop:CGFloat = 10
        let labelWidth = (frame.width - marginLeft) / 3
        okPointsView = UIView(frame: CGRectMake(marginLeft, marginTop, labelWidth, frame.height - marginTop))
        okPointsLabel = UILabel(frame: CGRectMake(0, 0, labelWidth, frame.height - marginTop))
        okPointsLabel.textAlignment = NSTextAlignment.Center
        okPointsLabel.textColor = UIColor.blackColor()
        //okPointsLabel.backgroundColor = UIColor.greenColor()
        okPointsLabel.text = "\(self.okPoints) 😌"
        okPointsView.addSubview(okPointsLabel)
        self.addSubview(okPointsView)
        
        
        goodPointsView = UIView(frame: CGRectMake(okPointsView.frame.maxX, marginTop, labelWidth, frame.height - marginTop))
        goodPointsLabel = UILabel(frame: CGRectMake(0, 0, labelWidth, frame.height - marginTop))
        goodPointsLabel.textAlignment = NSTextAlignment.Center
        goodPointsLabel.textColor = UIColor.blackColor()
        //goodPointsLabel.backgroundColor = UIColor.greenColor()
        goodPointsLabel.text = "\(self.goodPoints) 😀"
        goodPointsView.addSubview(goodPointsLabel)
        self.addSubview(goodPointsView)
        
        lovePointsView = UIView(frame: CGRectMake(goodPointsView.frame.maxX, marginTop, labelWidth, frame.height - marginTop))
        lovePointsLabel = UILabel(frame: CGRectMake(0, 0, labelWidth, frame.height - marginTop))
        lovePointsLabel.textAlignment = NSTextAlignment.Center
        lovePointsLabel.textColor = UIColor.blackColor()
        //lovePointsLabel.backgroundColor = UIColor.greenColor()
        lovePointsLabel.text = "\(self.lovePoints) 😍"
        lovePointsView.addSubview(lovePointsLabel)
        self.addSubview(lovePointsView)
        
        animationLabel = UILabel(frame: CGRectMake(0, 0, labelWidth, frame.height - marginTop))
        animationLabel.textAlignment = NSTextAlignment.Center
        animationLabel.textColor = UIColor.blackColor()
        animationLabel.font = UIFont.boldSystemFontOfSize(20)
        //lovePointsLabel.backgroundColor = UIColor.greenColor()
        animationLabel.text = "test"
        animationLabel.alpha = 0
        self.addSubview(animationLabel)
    }
    
    func addOkPoints(points:Int)
    {
        okPointsView.layer.removeAllAnimations()
        self.okPoints! += points
        //okPointsLabel.text = "\(self.okPoints!) 😌"
        //animateView(okPointsView)
        
        
        animationLabel.text = "+\(points)"
        animationLabel.textColor = UIColor.greenColor()
        animationLabel.center = okPointsView.center
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.animationLabel.transform = CGAffineTransformScale(self.animationLabel.transform, 2, 2)
            self.animationLabel.alpha = 1
            
            }, completion: { (value: Bool) in
                self.animationLabel.alpha = 0
                self.animationLabel.transform = CGAffineTransformIdentity
                self.okPointsLabel.text = "\(self.okPoints!) 😌"
                self.animateView(self.okPointsView)
                

        })
    }
    
    func subtractOkPoints(points:Int)
    {
        okPointsView.layer.removeAllAnimations()
        self.okPoints! -= points
        if( okPoints < 0)
        {
            okPoints = 0
        }
        
        animationLabel.transform = CGAffineTransformScale(animationLabel.transform, 1.5, 1.5)
        animationLabel.text = "-\(points)"
        animationLabel.textColor = UIColor.redColor()
        animationLabel.center = okPointsView.center
        animationLabel.alpha = 1
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.animationLabel.alpha = 0
            self.animationLabel.transform = CGAffineTransformIdentity
            }, completion: { (value: Bool) in
                self.animationLabel.alpha = 0
                self.animationLabel.transform = CGAffineTransformIdentity
                self.okPointsLabel.text = "\(self.okPoints!) 😌"
                
                self.animateView(self.okPointsView)
        })
    }

    func addGoodPoints(points:Int)
    {
        goodPointsView.layer.removeAllAnimations()
        self.goodPoints! += points
        //goodPointsLabel.text = "\(self.goodPoints!) 😀"
        //animateView(goodPointsView)
        
        animationLabel.text = "+\(points)"
        animationLabel.textColor = UIColor.greenColor()
        animationLabel.center = goodPointsView.center
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.animationLabel.transform = CGAffineTransformScale(self.animationLabel.transform, 2, 2)
            self.animationLabel.alpha = 1
            
            }, completion: { (value: Bool) in
                self.animationLabel.alpha = 0
                self.animationLabel.transform = CGAffineTransformIdentity
                self.goodPointsLabel.text = "\(self.goodPoints!) 😀"
                self.animateView(self.goodPointsView)
        })
    }
    
    func subtractGoodPoints(points:Int)
    {
        goodPointsView.layer.removeAllAnimations()
        self.goodPoints! -= points
        if( goodPoints < 0)
        {
            goodPoints = 0
        }

        animationLabel.transform = CGAffineTransformScale(animationLabel.transform, 1.5, 1.5)
        animationLabel.text = "-\(points)"
        animationLabel.textColor = UIColor.redColor()
        animationLabel.center = goodPointsView.center
        animationLabel.alpha = 1
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            
            self.animationLabel.alpha = 0
            self.animationLabel.transform = CGAffineTransformIdentity
            }, completion: { (value: Bool) in
                self.animationLabel.alpha = 0
                self.animationLabel.transform = CGAffineTransformIdentity
                self.goodPointsLabel.text = "\(self.goodPoints!) 😀"
                self.animateView(self.goodPointsView)
        })
    }
    
    func addLovePoints(points:Int)
    {
        lovePointsView.layer.removeAllAnimations()
        self.lovePoints! += points
        lovePointsLabel.text = "\(self.lovePoints!) 😍"
        animateView(lovePointsView)
    }
    
    func animateView(view:UIView)
    {
        var pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
        pulseAnimation.duration = 0.3
        pulseAnimation.toValue = NSNumber(float: 0.3)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = 5
        pulseAnimation.delegate = self
        view.layer.addAnimation(pulseAnimation, forKey: "asd")
    }
    
}
