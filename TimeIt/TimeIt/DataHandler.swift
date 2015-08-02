//
//  PopulateData.swift
//  TimeIt
//
//  Created by knut on 18/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation
import CoreData
import UIKit





class DataHandler
{
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var periodsItems:[Period]!
    var historicEventItems:[HistoricEvent]!
    init()
    {
        loadGameData()
        historicEventItems = []
        periodsItems = []
    }
    
    func populateData()
    {

        let t1 = PeriodData(from: 1990, to: 2000)
        let t2 = PeriodData(from: 1980, to: 1990)
        let t3 = PeriodData(from: 1970, to: 1980)
        let t4 = PeriodData(from: 1960, to: 1970)
        let t5 = PeriodData(from: 1950, to: 1960)
        let t6 = PeriodData(from: 1940, to: 1950)
        let t7 = PeriodData(from: 1930, to: 1940)
        let t8 = PeriodData(from: 1920, to: 1930)
        let t9 = PeriodData(from: 1910, to: 1920)
        let t10 = PeriodData(from: 1900, to: 1910)
        let t11 = PeriodData(from: 1890, to: 1900)
        let t12 = PeriodData(from: 1880, to: 1890)
        let t13 = PeriodData(from: 1870, to: 1880)
        let t14 = PeriodData(from: 1860, to: 1870)
        let t15 = PeriodData(from: 1850, to: 1860)
        let t16 = PeriodData(from: 1840, to: 1850)
        let t17 = PeriodData(from: 1830, to: 1840)
        let t18 = PeriodData(from: 1820, to: 1830)
        let t19 = PeriodData(from: 1810, to: 1820)
        let t20 = PeriodData(from: 1800, to: 1810)
        
        let f1 = PeriodData(from: 1950, to: 2000,periods: [t1,t2,t3,t4,t5],timelineItem:true)
        let f2 = PeriodData(from: 1900, to: 1950,periods: [t6,t7,t8,t9,t10],timelineItem:true)
        let f3 = PeriodData(from: 1850, to: 1900,periods: [t11,t12,t13,t14,t15])
        let f4 = PeriodData(from: 1800, to: 1850,periods: [t16,t17,t18,t19,t20])
        let f5 = PeriodData(from: 1750, to: 1800)
        let f6 = PeriodData(from: 1700, to: 1750)
        let f7 = PeriodData(from: 1650, to: 1700)
        let f8 = PeriodData(from: 1600, to: 1650)
        let f9 = PeriodData(from: 1550, to: 1600)
        let f10 = PeriodData(from: 1500, to: 1550)
        let f11 = PeriodData(from: 1450, to: 1500)
        let f12 = PeriodData(from: 1400, to: 1450)
        let f13 = PeriodData(from: 1350, to: 1400)
        let f14 = PeriodData(from: 1300, to: 1350)
        let f15 = PeriodData(from: 1250, to: 1300)
        let f16 = PeriodData(from: 1200, to: 1250)
        let f17 = PeriodData(from: 1150, to: 1200)
        let f18 = PeriodData(from: 1100, to: 1150)
        let f19 = PeriodData(from: 1050, to: 1100)
        let f20 = PeriodData(from: 1000, to: 1050)
 
        
        let h1 = PeriodData(from: 1900, to: 2000, periods: [f1,f2])
        let h2 = PeriodData(from: 1800, to: 1900, periods: [f3,f4],timelineItem:true)
        let h3 = PeriodData(from: 1700, to: 1800, periods: [f5,f6],timelineItem:true)
        let h4 = PeriodData(from: 1600, to: 1700, periods: [f7,f8],timelineItem:true)
        let h5 = PeriodData(from: 1500, to: 1600, periods: [f9,f10],timelineItem:true)
        let h6 = PeriodData(from: 1400, to: 1500, periods: [f11,f12])
        let h7 = PeriodData(from: 1300, to: 1400, periods: [f13,f14])
        let h8 = PeriodData(from: 1200, to: 1300, periods: [f15,f16])
        let h9 = PeriodData(from: 1100, to: 1200, periods: [f17,f18])
        let h10 = PeriodData(from: 1000, to: 1100, periods: [f19,f20])
        let h11 = PeriodData(from: 900, to: 1000)
        let h12 = PeriodData(from: 800, to: 900)
        let h13 = PeriodData(from: 700, to: 800)
        let h14 = PeriodData(from: 600, to: 700)
        let h15 = PeriodData(from: 500, to: 600)
        let h16 = PeriodData(from: 400, to: 500)
        let h17 = PeriodData(from: 300, to: 400)
        let h18 = PeriodData(from: 200, to: 300)
        let h19 = PeriodData(from: 100, to: 200)
        let h20 = PeriodData(from: 0, to: 100)
        /*
        let h61 = PeriodData(from: -500, to:-400 )
        let h62 = PeriodData(from: -400, to:-300 )
        let h63 = PeriodData(from: -300, to:-200 )
        let h64 = PeriodData(from: -200, to:-100 )
        let h65 = PeriodData(from: -100, to:0 )
        */
        
        let fh1 = PeriodData(from: 1500, to: 2000,periods:[h1,h2,h3,h4,h5])
        let fh2 = PeriodData(from: 1000, to: 1500,periods:[h6,h7,h8,h9,h10],timelineItem:true)
        let fh3 = PeriodData(from: 500, to: 1000,periods:[h11,h12,h13,h14,h15],timelineItem:true)
        let fh4 = PeriodData(from: 0, to: 500,periods:[h16,h17,h18,h19,h20],timelineItem:true)
        let fh5 = PeriodData(from: -500, to: 0)
        let fh6 = PeriodData(from: -1000, to: -500)
        
        let mil1 = PeriodData(from: 1000, to: 2000,periods:[fh2,fh1])
        let mil2 = PeriodData(from: 0, to: 1000,periods:[fh3,fh4])
        let mil3 = PeriodData(from: -1000, to: 0,periods:[fh5,fh6],timelineItem:true)
        
        var dataToPopulate = [mil3,mil2,mil1]
        
        savePeriodesFromCollection(dataToPopulate)
        
        //test
        /*
        createHistoricEvent("King David conquers Jerusalem", year:-990, type:periodType.fivehundred)
        createHistoricEvent("First Olympiad in Greece", year:-776, type:periodType.fivehundred)
        createHistoricEvent("Rome founded by Romulus", year:-753, type:periodType.fivehundred)
        createHistoricEvent("Aesop’s fables thought to be written", year:-990, type:periodType.fivehundred)
        createHistoricEvent("Babylon ruled by Nebuchadnezzar", from: -605, to: -562, type:periodType.fivehundred)
        createHistoricEvent("Buddha born in India.", year:-563, type:periodType.fivehundred)
        createHistoricEvent("Confucius born in China", year:-551, type:periodType.fivehundred)
        createHistoricEvent("Roman calendar introduced", year:-535, type:periodType.fivehundred, text: "It had 10 months, with 304 days in a year that began in March.")
        createHistoricEvent("Pythagoras describes his theorem", year:-532, type:periodType.fivehundred,text:"Pythagoras of Crotona describes the relations between sides of right-angled triangle, and tone vibrations.")
        createHistoricEvent("Rome as a Republic founded", year:-500, type:periodType.fivehundred, text:"End of monarchy in Rome")
        createHistoricEvent("Socrates drink hemlock", year:-399, type:periodType.fivehundred, text:"Socrates is required to drink hemlock to end his life after being found guilty of corrupting the youth of Athens")
        createHistoricEvent("Aristotle writes Meteorologica", year:-990, type:periodType.fivehundred,text: "The first book on weather.")
        createHistoricEvent("Persian empire", from:-550 , to:-330, type:periodType.fivehundred)
        createHistoricEvent("Alexander the Great rule Macedonia", from:-336 , to:-323, type:periodType.fivehundred)
        createHistoricEvent("Livius Andronicus is the first Roman poet", year:-240, type:periodType.fivehundred)
        
        createHistoricEvent("Archimedes explains principles of lever", year:-212, type:periodType.fivehundred, text:"Area of circle, principles of lever, the screw, and buoyancy.")
        createHistoricEvent("Eratosthenes determines the size of Earth", year:-194, type:periodType.fivehundred)
        createHistoricEvent("The Romans invade Britain", year:-55, type:periodType.fivehundred)
        createHistoricEvent("Rule of Cleopatra in Egypt", from:-51, to: -30, type:periodType.fivehundred)
        createHistoricEvent("Julius Caesar assassinated", year:-44, type:periodType.fivehundred)
        createHistoricEvent("Solomon builds the Temple in Jerusalem", year:-950, type:periodType.fivehundred)
        
        createHistoricEvent("Tiberius becomes roman Emperor", year:14, type:periodType.hundred)
        createHistoricEvent("Nero becomes last Caesar", year:54, type:periodType.hundred)
        createHistoricEvent("First seismoscope developed in China", year:132, type:periodType.hundred)
        createHistoricEvent("Marcus Aurelius becomes emperor of Rome", year:161, type:periodType.hundred)
        createHistoricEvent("Emperor Commodus assisinated in Rome", year:193, type:periodType.hundred)
        createHistoricEvent("Founding of Constantinople", year:330, type:periodType.hundred)
        createHistoricEvent("Library of Alexandria is destroyed by fire", year:391, type:periodType.hundred)
        
        createHistoricEvent("Angles and Saxons conquer Britain", year:449, type:periodType.hundred)
        createHistoricEvent("Attila the Hun crosses the Rhine into Gaul", year:451, type:periodType.hundred)
        createHistoricEvent("Vandals conquer Rome", year:455, type:periodType.hundred)
        createHistoricEvent("Battle of Vouille", year:507, type:periodType.hundred, text:"Clovis, King of the Franks, defeats the Visigoths at the Battle of Vouille")
        createHistoricEvent("The plague of Europe", from:542, to:593, type:periodType.hundred)
        createHistoricEvent("The Lombards invade Italy", year:568, type:periodType.hundred)
        
        createHistoricEvent("Dagobert becomes King of the Franks", year:629, type:periodType.hundred)
        createHistoricEvent("Muhammad the Prophet dies", year:632, type:periodType.hundred)
        createHistoricEvent("Arabs destroy the city of Carthage", year:695, type:periodType.hundred, text:"Ending Byzantine rule in North Africa")
        createHistoricEvent("Moslem conquest of Spain", year:711, type:periodType.hundred)
        createHistoricEvent("Battle of Tours", year:732, type:periodType.hundred, text:"Frankish forces led by Charles Martel halt the Muslim advance into Europe")
        createHistoricEvent("First printed newspaper appears in Peking", year:748, type:periodType.hundred)
        
        createHistoricEvent("Battle of Atlakh", year:751, type:periodType.hundred, text: "Islamic army defeats the Chinese at the Battle of Atlakh, giving Muslims control of the Silk Road.")
        createHistoricEvent("Charlemagne becomes king of the Franks", year:771, type:periodType.hundred)
        createHistoricEvent("Charlemagne declares war against the Saxons in Germany", year:748, type:periodType.hundred)
        createHistoricEvent("Musa al-Kwarizmi born in Baghdad", year:780, type:periodType.hundred, text:"He introduced Hindu-Arabic numerals in his book Kitab al-jabr wa al-mugabalah.")
        createHistoricEvent("Vikings invade Ireland", year:795, type:periodType.hundred)
        createHistoricEvent("Charlemagne dies of pleurisy", year:814, type:periodType.hundred)
        createHistoricEvent("Toilet paper thought be used first in China", year:850, type:periodType.hundred)
        createHistoricEvent("Iceland discovered", year:861, type:periodType.hundred)
        createHistoricEvent("World’s first printed book ", year:868, type:periodType.hundred,text:"The world’s first printed book The Diamond Sutra is produced in China.")
        createHistoricEvent("Vikings settle in Iceland", year:874, type:periodType.hundred)
        createHistoricEvent("First record of an automatic instrument", year:890, type:periodType.hundred, text:"First record of an automatic instrument, an organ-building treatise called Banu Musa.")
        createHistoricEvent("Vikings discover Greenland", year:900, type:periodType.hundred)
        createHistoricEvent("Earliest recorded mention of playing cards, found in China.", year:969, type:periodType.hundred)
        createHistoricEvent("Mieczyslaw I becomes first ruler of Poland", year:960, type:periodType.hundred)
        createHistoricEvent("The Capetian dynasty", from:987 , to:1328, type:periodType.hundred)
        createHistoricEvent("Musical notation systematised.", year:990, type:periodType.hundred)
        
        createHistoricEvent("Leif Ericson lands in North America, calling it Vinland", year:1000, type:periodType.fifty)
        createHistoricEvent("Paper money printed in China.", year:1023, type:periodType.fifty)
        createHistoricEvent("William the Conqueror invades England", year:1066, type:periodType.fifty,text:"William the Conqueror, from Normandy in France, invades England, defeats last Saxon king, Harold II, at Battle of Hastings")
        createHistoricEvent("Shen Kua of China writes about the magnetic compass", year:1086, type:periodType.fifty)
        createHistoricEvent("First modern university established in Bologna, Italy", year:1088, type:periodType.fifty)
        createHistoricEvent("Leif Ericson lands in North America, calling it Vinland", year:1000, type:periodType.fifty)
        createHistoricEvent("Leif Ericson lands in North America, calling it Vinland", year:1000, type:periodType.fifty)
        createHistoricEvent("Leif Ericson lands in North America, calling it Vinland", year:1000, type:periodType.fifty)
        createHistoricEvent("Leif Ericson lands in North America, calling it Vinland", year:1000, type:periodType.fifty)
        createHistoricEvent("Leif Ericson lands in North America, calling it Vinland", year:1000, type:periodType.fifty)
        */
        
        

        
        createHistoricEvent("war (1918-1939)", from: 1918, to:1939, type:periodType.fifty)
        createHistoricEvent("Test between (1918-1960)", from: 1918, to:1960, type:periodType.fifty,text:"First record of an automatic instrument, an organ-building treatise called Banu Musa. First record of an automatic instrument, an organ-building treatise called Banu Musa.")
        createHistoricEvent("Someone is born (1751)", year: 1751, type:periodType.fifty)
        createHistoricEvent("old war (1918-1939)", from: -540, to:-300, type:periodType.fivehundred, text:"The best approach to add padding to a UILabel is to subclass UILabel and add an edgeInsets property. You then set the desired insets and the label will be drawn accordingly.")

        save()
        
        dataPopulatedID = 1
        saveGameData()
        
        
    }
    
    func createHistoricEvent(title:String, from: Int, to:Int, type:periodType, text:String = "")
    {
        let q1 = HistoricEvent.createInManagedObjectContext(self.managedObjectContext!,  title:title, from: from, to:to, text:text)
        hookQuestionToPeriods(q1,type: type)
    }
    
    func createHistoricEvent(title:String, year: Int, type:periodType, text:String = "")
    {
        let q1 = HistoricEvent.createInManagedObjectContext(self.managedObjectContext!,  title:title, year:year, text:text)
        hookQuestionToPeriods(q1,type: type)
    }
    
    func updateOkScore(historicEvent:HistoricEvent, deltaScore:Int)
    {
        //okScoreID = Int(okScoreID as! NSNumber) + deltaScore
        historicEvent.okScore = historicEvent.okScore + Int16(deltaScore)
        if historicEvent.okScore < 0
        {
            historicEvent.okScore = 0
        }
        save()
    }
    
    func updateGoodScore(historicEvent:HistoricEvent, deltaScore:Int)
    {
        //goodScoreID = Int(goodScoreID as! NSNumber) + deltaScore
        historicEvent.goodScore = historicEvent.goodScore + Int16(deltaScore)
        if historicEvent.goodScore < 0
        {
            historicEvent.goodScore = 0
        }
        save()
    }
    
    func updateLoveScore(historicEvent:HistoricEvent, deltaScore:Int)
    {
        //loveScoreID = Int(loveScoreID as! NSNumber) + deltaScore
        historicEvent.loveScore = historicEvent.loveScore + Int16(deltaScore)
        if historicEvent.loveScore < 0
        {
            historicEvent.loveScore = 0
        }
        save()
    }
    
    func updateGameData(deltaOkPoints:Int,deltaGoodPoints:Int,deltaLovePoints:Int)
    {
        okScoreID = Int(okScoreID as! NSNumber) + deltaOkPoints
        goodScoreID = Int(goodScoreID as! NSNumber) + deltaGoodPoints
        loveScoreID = Int(loveScoreID as! NSNumber) + deltaLovePoints
    }
    
    func shuffleEvents()
    {
        historicEventItems = shuffle(historicEventItems)
    }
    
    func shuffle<C: MutableCollectionType where C.Index == Int>(var list: C) -> C {
        let ecount = count(list)
        for i in 0..<(ecount - 1) {
            let j = Int(arc4random_uniform(UInt32(ecount - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    

    
    func savePeriodesFromCollection(dataToPopulate:[PeriodData],parentPeriod:Period? = nil)
    {
        for periodData in dataToPopulate
        {
            var period = Period.createInManagedObjectContext(self.managedObjectContext!, from: periodData.from, to:periodData.to, timelineItem:periodData.timeline)
            save()
            if let parent = parentPeriod
            {
                parent.addPeriod(period)
            }
            periodsItems.append(period)
            savePeriodesFromCollection(periodData.periods,parentPeriod: period)
        }
    }
    
    func getTimelineItems() -> [Period]
    {
        //var timelineItems:[Period] = []
        //periodsItems.filter(<#includeElement: (T) -> Bool##(T) -> Bool#>)
        let filteredArray = periodsItems.filter() {
            if ($0 as Period).timelinePocket == 1 {
                return true
            } else {
                return false
            }
        }
        return filteredArray
    }
    
    func hookQuestionToPeriods(question:HistoricEvent, type: periodType)
    {
        println("try hookup event \(question.title) on periodType \(type.description)")
        var found = false
        for period in periodsItems
        {
            if(period.type == Int16(type.rawValue))
            {
                if((question.fromYear >= period.fromYear  && question.fromYear <= period.toYear)
                    || (question.toYear <= period.toYear  && question.toYear >= period.fromYear))
                {
                    found = true
                    question.addPeriod(period)
                    //period.addEvent(question)
                    println("hooked up event \(question.title) on period \(period.fromYear) - \(period.toYear)")
                }
            }
        }
        if(!found)
        {
            println("Could not hookup event \(question.title) on period of \(type.description)")
        }
        
    }
    

    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
    
    func fetchData() {

        // Create a new fetch request using the LogItem entity
        // eqvivalent to select * from Relation
        let fetchEvents = NSFetchRequest(entityName: "HistoricEvent")
        
        //let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        let predicate = NSPredicate(format: "periods.@count > 0") //!=NULL
        //let predicate = NSPredicate(format: "titlenumber contains %@", "Worst")
        // Set the predicate on the fetch request
        fetchEvents.predicate = predicate
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchEvents, error: nil) as? [HistoricEvent] {
            historicEventItems = fetchResults
        }
        
        let fetchPeriods = NSFetchRequest(entityName: "Period")
        let sortDescriptor = NSSortDescriptor(key: "fromYear", ascending: true)
        fetchPeriods.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchPeriods, error: nil) as? [Period] {
            periodsItems = fetchResults
        }
    }
    
    let DataPopulatedKey = "DataPopulated"
    //let BedroomFloorKey = "BedroomFloor"
    //let BedroomWallKey = "BedroomWall"
    let OkScoreKey = "OkScore"
    let GoodScoreKey = "GoodScore"
    let LoveScoreKey = "LoveScore"
    
    
    var dataPopulatedID:AnyObject = 0
    var okScoreID:AnyObject = 0
    var goodScoreID:AnyObject = 0
    var loveScoreID:AnyObject = 0
    //var bedroomFloorID: AnyObject = 101
    //var bedroomWallID: AnyObject = 101

    func loadGameData() {
        // getting path to GameData.plist
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! String
        let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
        let fileManager = NSFileManager.defaultManager()
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = NSBundle.mainBundle().pathForResource("GameData", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                println("Bundle GameData.plist file is --> \(resultDictionary?.description)")
                fileManager.copyItemAtPath(bundlePath, toPath: path, error: nil)
                println("copy")
            } else {
                println("GameData.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            println("GameData.plist already exits at path. \(path)")
            // use this to delete file from documents directory
            //fileManager.removeItemAtPath(path, error: nil)
        }
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Loaded GameData.plist file is --> \(resultDictionary?.description)")
        var myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            //loading values
            dataPopulatedID = dict.objectForKey(DataPopulatedKey)!
            okScoreID = dict.objectForKey(OkScoreKey)!
            goodScoreID = dict.objectForKey(GoodScoreKey)!
            loveScoreID = dict.objectForKey(LoveScoreKey)!
            //bedroomWallID = dict.objectForKey(BedroomWallKey)!
            //...
        } else {
            println("WARNING: Couldn't create dictionary from GameData.plist! Default values will be used!")
        }
    }
    
    func saveGameData() {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("GameData.plist")
        var dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject(dataPopulatedID, forKey: DataPopulatedKey)
        dict.setObject(okScoreID, forKey: OkScoreKey)
        dict.setObject(goodScoreID, forKey: GoodScoreKey)
        dict.setObject(loveScoreID, forKey: LoveScoreKey)
        //dict.setObject(bedroomWallID, forKey: BedroomWallKey)
        //...
        //writing to GameData.plist
        dict.writeToFile(path, atomically: false)
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Saved GameData.plist file is --> \(resultDictionary?.description)")
    }
}


