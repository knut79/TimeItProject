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
    
    @NSManaged var toYear: Int32
    @NSManaged var fromYear: Int32
    @NSManaged var type: Int16
    @NSManaged var periods: NSSet
    @NSManaged var events: NSSet
    @NSManaged var period: Period?
    @NSManaged var timelinePocket:Boolean
    
    //added on picture with coordinates on parent filepoint
    class func createInManagedObjectContext(moc: NSManagedObjectContext, from: Int32, to:Int32, timelineItem:Bool) -> Period{
        let newitem = NSEntityDescription.insertNewObjectForEntityForName("Period", inManagedObjectContext: moc) as! Period
        newitem.fromYear = Int32(from)
        newitem.toYear = Int32(to)
        //HACK
        /*
        let toHack = {() -> Int32 in
            if to < -1000
            {
                return -1000
            }
            else
            {
                return to > 2000 ? 2000 : to
            }
            }()
        */
        let toHack = to > 2000 ? 2000 : to
        let fromHack = from < -1000 ? -1000 : from
        var diff = toHack - fromHack
        //SUPERHACK
        if from == minWayBack && to == maxWayBack
        {
            newitem.type = Int16(periodType.fivehundred.rawValue)
        }
        else if(diff >= 1000)
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
            
            
            //let fyear = self.fromYear < 0 ? "\(unaryFromYear)BC" : "\(self.fromYear)"
            let tyear =  {() -> String in
                if self.toYear > 2000
                {
                    return "Now"
                }
                else if self.toYear < -1000
                {
                    let value = (self.toYear / aMillion) * -1
                    return "\(value) m.y.a"
                }
                else
                {
                    return self.toYear < 0 ? "\(self.toYear * -1)BC" : "\(self.toYear)"
                }
            }()
            let fyear =  {() -> String in
                if self.fromYear == minWayBack
                {
                    return "Way back"
                }
                else if self.fromYear < -1000
                {
                    let value = (self.fromYear / aMillion) * -1
                    return "\(value) m.y.a"
                }
                else
                {
                    return self.fromYear < 0 ? "\(self.fromYear * -1)BC" : "\(self.fromYear)"
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
