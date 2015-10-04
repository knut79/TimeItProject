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
    
    var goodPoints:Int!

    var lovePointsView:UIView!
    var lovePoints:Int!
    var lovePointsLabel:UILabel!
    
    var animationLabel:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

    }
    
    init(frame: CGRect, okScore:Int, goodScore:Int, loveScore:Int) {
        super.init(frame: frame)
        
        self.okPoints = okScore
        self.goodPoints = goodScore
        self.lovePoints = loveScore
        let marginLeft:CGFloat = 10
        let marginTop:CGFloat = 10
        let labelWidth = (frame.width - marginLeft) / 2
        okPointsView = UIView(frame: CGRectMake(marginLeft, marginTop, labelWidth, frame.height - marginTop))
        okPointsLabel = UILabel(frame: CGRectMake(0, 0, labelWidth, frame.height - marginTop))
        okPointsLabel.textAlignment = NSTextAlignment.Center
        okPointsLabel.textColor = UIColor.blackColor()
        okPointsLabel.text = "\(self.okPoints) 😌"
        okPointsView.addSubview(okPointsLabel)
        self.addSubview(okPointsView)

        
        lovePointsView = UIView(frame: CGRectMake(okPointsView.frame.maxX, marginTop, labelWidth, frame.height - marginTop))
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
        animationLabel.layer.shadowOpacity = 1.0
        animationLabel.layer.shadowRadius = 0.7
        animationLabel.layer.shadowColor = UIColor.blackColor().CGColor
        animationLabel.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        animationLabel.text = "test"
        animationLabel.alpha = 0
        self.addSubview(animationLabel)
    }
    
    func newValues() -> Bool
    {
        if okPoints > 0
        {
            return true
        }
        
        
        if lovePoints > 0
        {
            return true
        }
        
        return false
    }
    
    func addOkPoints(points:Int,completion: (() -> (Void))? = nil)
    {
        if points <= 0
        {
            completion?()
        }
        else
        {
            okPointsView.layer.removeAllAnimations()
            okPoints! += points
            
            animationLabel.text = "+\(points)"
            
            animateAddPoints(okPointsView,completion: {() -> Void in
                
                self.okPointsLabel.text = "\(self.okPoints!) 😌"
                self.animateView(self.okPointsView)
                completion?()
            })
        }
    }


    
    func addLovePoints(points:Int)
    {
        if points <= 0
        {
            return
        }
        else
        {
            lovePointsView.layer.removeAllAnimations()
            lovePoints! += points
            
            animationLabel.text = "+\(points)"
            
            animateAddPoints(lovePointsView,completion: {() -> Void in
                
                self.lovePointsLabel.text = "\(self.lovePoints!) 😍"
                self.animateView(self.lovePointsView)
            })
        }
    }
    
    func animateAddPoints(animateView:UIView,completion: (() -> Void)?)
    {
        animationLabel.textColor = UIColor.greenColor()
        animationLabel.center = animateView.center
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.animationLabel.transform = CGAffineTransformScale(self.animationLabel.transform, 2, 2)
            self.animationLabel.alpha = 1
            
            }, completion: { (value: Bool) in
                self.animationLabel.alpha = 0
                self.animationLabel.transform = CGAffineTransformIdentity
                completion?()

        })
    }
    
    func subtractOkPoints(let points:Int)
    {
        if self.okPoints <= 0
        {
            return
        }
        
        var positiveNegativePoints = points < 0 ? points * -1 : points
        
        okPointsView.layer.removeAllAnimations()
        let deltaPoints = positiveNegativePoints - self.okPoints!
        self.okPoints! -= positiveNegativePoints
        if( okPoints < 0)
        {
            okPoints = 0
            positiveNegativePoints = deltaPoints
        }
        
        animationLabel.text = "-\(positiveNegativePoints)"
        self.okPointsLabel.text = "\(self.okPoints!) 😌"
        animateSubractPoints(okPointsView,completion: {() -> Void in
            
            self.animateView(self.okPointsView)
        })

    }
    
    /*
    func subtractGoodPoints(var points:Int)
    {
        if self.goodPoints <= 0
        {
            return
        }
        goodPointsView.layer.removeAllAnimations()
        var deltaPoints = points - self.okPoints!
        self.goodPoints! -= points
        if( goodPoints < 0)
        {
            goodPoints = 0
            points = deltaPoints
        }

        animationLabel.text = "-\(points)"
        self.goodPointsLabel.text = "\(self.goodPoints!) 😀"
        animateSubractPoints(goodPointsView,completion: {() -> Void in
            
            self.animateView(self.goodPointsView)
        })
        
        animationLabel.transform = CGAffineTransformScale(animationLabel.transform, 1.5, 1.5)
    }
    */
    
    func animateSubractPoints(animateView:UIView,completion: (() -> Void)?)
    {
        self.animationLabel.transform = CGAffineTransformIdentity

        animationLabel.textColor = UIColor.redColor()
        animationLabel.center = animateView.center
        animationLabel.alpha = 1
        UIView.animateWithDuration(1, animations: { () -> Void in
            
            self.animationLabel.frame.offsetInPlace(dx: 0, dy: self.animationLabel.frame.height )
            self.animationLabel.alpha = 0
            self.animationLabel.transform = CGAffineTransformScale(self.animationLabel.transform, 0.3, 0.3)
            }, completion: { (value: Bool) in
                self.animationLabel.alpha = 0
                self.animationLabel.transform = CGAffineTransformIdentity
                completion?()
        })
    }
    

    
    func animateView(view:UIView)
    {
        let pulseAnimation:CABasicAnimation = CABasicAnimation(keyPath: "opacity");
        pulseAnimation.duration = 0.3
        pulseAnimation.toValue = NSNumber(float: 0.3)
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true;
        pulseAnimation.repeatCount = 5
        pulseAnimation.delegate = self
        view.layer.addAnimation(pulseAnimation, forKey: "asd")
    }
    
}
