//
//  HistoricEvent.swift
//  TimeIt
//
//  Created by knut on 12/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import CoreData

class HistoricEvent: NSManagedObject {
    
    @NSManaged var toYear: Int16
    @NSManaged var fromYear: Int16
    @NSManaged var type: Int16
    @NSManaged var periods: NSSet

    @NSManaged var text: String
    @NSManaged var title: String
    
    @NSManaged var okScore:Int16
    @NSManaged var goodScore:Int16
    @NSManaged var loveScore:Int16
    
    @NSManaged var level:Int16
    @NSManaged var tags:String
    
    @NSManaged var idForUpdate:Int16

    //added on picture with coordinates on parent filepoint
    class func createInManagedObjectContext(moc: NSManagedObjectContext, idForUpdate:Int, title:String, from: Int, to:Int, text:String, level:Int) -> HistoricEvent{
        let newitem = NSEntityDescription.insertNewObjectForEntityForName("HistoricEvent", inManagedObjectContext: moc) as! HistoricEvent
        newitem.fromYear = Int16(from)
        newitem.toYear = Int16(to)
        newitem.type = Int16(eventType.periode.rawValue)
        newitem.text = text
        newitem.title = title
        newitem.periods = NSMutableSet()
        newitem.tags = ""
        newitem.level = Int16(level)
        newitem.idForUpdate = Int16(idForUpdate)
        return newitem
    }
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, idForUpdate:Int, title:String, year: Int, text:String, level:Int) -> HistoricEvent{
        let newitem = NSEntityDescription.insertNewObjectForEntityForName("HistoricEvent", inManagedObjectContext: moc) as! HistoricEvent
        newitem.fromYear = Int16(year)
        newitem.toYear = Int16(year)
        newitem.type = Int16(eventType.singleYear.rawValue)
        newitem.text = text
        newitem.title = title
        newitem.periods = NSMutableSet()
        newitem.tags = ""
        newitem.level = Int16(level)
        newitem.idForUpdate = Int16(idForUpdate)
        return newitem
    }
    
    var formattedToYear:String
    {
        get{
            return self.toYear < 0 ? "\(self.toYear * -1)BC" : "\(self.toYear)"
        }
    }
    
    var formattedFromYear:String
        {
        get{
            return self.fromYear < 0 ? "\(self.fromYear * -1)BC" : "\(self.fromYear)"
        }
    }
    
    var formattedTime:String
        {
        get{
            let unaryFromYear = self.fromYear * -1
            let unaryToYear = self.toYear * -1
            let fyear = self.fromYear < 0 ? "\(unaryFromYear)BC" : "\(self.fromYear)"
            let tyear = self.toYear < 0 ? "\(unaryToYear)BC" : "\(self.toYear)"
            return type == Int16(eventType.singleYear.rawValue) ? "\(fyear)" : "\(fyear) - \(tyear)"
        }
    }
    
    func addPeriod(period:Period) {
        
        var items: NSMutableSet
        items = self.mutableSetValueForKey("periods")
        items.addObject(period)
    }
    
}

