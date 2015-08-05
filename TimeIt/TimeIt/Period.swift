//
//  Period.swift
//  TimeIt
//
//  Created by knut on 12/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import CoreData

class Period: NSManagedObject {
    
    @NSManaged var toYear: Int16
    @NSManaged var fromYear: Int16
    @NSManaged var type: Int16
    @NSManaged var periods: NSSet
    @NSManaged var events: NSSet
    @NSManaged var period: Period?
    @NSManaged var timelinePocket:Boolean
    
    //added on picture with coordinates on parent filepoint
    class func createInManagedObjectContext(moc: NSManagedObjectContext, from: Int, to:Int, timelineItem:Bool) -> Period{
        let newitem = NSEntityDescription.insertNewObjectForEntityForName("Period", inManagedObjectContext: moc) as! Period
        newitem.fromYear = Int16(from)
        newitem.toYear = Int16(to)
        var diff = to - from
        
        if(diff >= 1000)
        {
            newitem.type = Int16(periodType.millenia.rawValue)
        }
        else if(diff >= 500)
        {
            newitem.type = Int16(periodType.fivehundred.rawValue)
        }
        else if(diff >= 100)
        {
            newitem.type = Int16(periodType.hundred.rawValue)
        }
        else if(diff >= 50)
        {
            newitem.type = Int16(periodType.fifty.rawValue)
        }
        else if(diff >= 10)
        {
            newitem.type = Int16(periodType.ten.rawValue)
        }
        else
        {
            newitem.type = Int16(periodType.unvalid.rawValue)
        }
        newitem.timelinePocket = timelineItem ? 1 : 0
        
        newitem.periods = NSMutableSet()
        newitem.events = NSMutableSet()
        return newitem
    }
    
    
    
    var formattedTime:String
        {
        get{
            let unaryFromYear = self.fromYear * -1
            
            let fyear = self.fromYear < 0 ? "\(unaryFromYear)BC" : "\(self.fromYear)"
            println("test from \(self.fromYear) to \(self.toYear)")
            let tyear =  {() -> String in
                if self.toYear >= 9999
                {
                    return "Now"
                }
                else
                {
                    let unaryToYear = self.toYear * -1
                    return self.toYear < 0 ? "\(unaryToYear)BC" : "\(self.toYear)"
                }
            }()
            return "\(fyear) - \(tyear)"
        }
    }
    
    var sortedPeriods:[AnyObject]
        {
        get{
            //NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"type1.size" ascending:YES];
            //NSArray *finalArray = [self.firstArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
            let sortDescriptor = NSSortDescriptor(key: "fromYear", ascending: true)
            var temp = self.periods.sortedArrayUsingDescriptors([sortDescriptor])
            return temp
        }
    }
    
    func addPeriod(period:Period) {
        
        var items: NSMutableSet
        items = self.mutableSetValueForKey("periods")
        items.addObject(period)
    }
    
    func addEvent(event:HistoricEvent) {
        
        var items: NSMutableSet
        items = self.mutableSetValueForKey("events")
        items.addObject(event)
    }

    func lowPercentHalfWindow() -> Int
    {
        //var val = Double(Int(self.toYear) - Int(self.fromYear)) * 0.05
        var val = Double(Int(self.toYear) - Int(self.fromYear)) * (lowPercentWindow / 2)
        return Int(val)
    }
 
    func highPercentHalfWindow() -> Int
    {
        //var val = Double(Int(self.toYear) - Int(self.fromYear)) * 0.1
        var val = Double(Int(self.toYear) - Int(self.fromYear)) * (highPercentWindow / 2)
        return Int(val)
    }

}
