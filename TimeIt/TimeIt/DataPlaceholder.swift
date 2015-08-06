//
//  DataPlaceholder.swift
//  TimeIt
//
//  Created by knut on 13/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation

class PeriodData {
    
    var from:Int32
    var to:Int32
    var periods:[PeriodData]
    var questions:[QuestionData]
    var timeline:Bool
    
    init(from:Int32,to:Int32,periods:[PeriodData],questions:[QuestionData], timelineItem:Bool = false)
    {
        self.from = from
        self.to = to
        self.periods = periods
        self.questions = questions
        timeline = timelineItem
    }
    
    init(from:Int32,to:Int32,periods:[PeriodData],timelineItem:Bool = false)
    {
        self.from = from
        self.to = to
        self.periods = periods
        self.questions = []
        self.timeline = timelineItem
    }
    
    /*
    init(from:Int,to:Int,questions:[QuestionData])
    {
        self.from = from
        self.to = to
        self.periods = []
        self.questions = questions
    }
    */
    init(from:Int32,to:Int32, timelineItem:Bool = false)
    {
        self.from = from
        self.to = to
        self.periods = []
        self.questions = []
        self.timeline = timelineItem
    }
    
    
}

class QuestionData {
    
    var title:String
    var text:String
    
    init(title:String,text:String)
    {
        self.title = title
        self.text = text
    }
    
}