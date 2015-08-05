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
    var todaysYear:Double!
    init()
    {
        loadGameData()
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: date)
        todaysYear = Double(components.year)
        historicEventItems = []
        periodsItems = []
    }
    
    func populateData(completePopulating: (() -> (Void))?)
    {

        
        let t1 = PeriodData(from: 1990, to: 9999)
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
        
        let f1 = PeriodData(from: 1950, to: 9999,periods: [t1,t2,t3,t4,t5],timelineItem:true)
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
 
        
        let h1 = PeriodData(from: 1900, to: 9999, periods: [f1,f2])
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
        
        let fh1 = PeriodData(from: 1500, to: 9999,periods:[h1,h2,h3,h4,h5])
        let fh2 = PeriodData(from: 1000, to: 1500,periods:[h6,h7,h8,h9,h10],timelineItem:true)
        let fh3 = PeriodData(from: 500, to: 1000,periods:[h11,h12,h13,h14,h15],timelineItem:true)
        let fh4 = PeriodData(from: 0, to: 500,periods:[h16,h17,h18,h19,h20],timelineItem:true)
        let fh5 = PeriodData(from: -500, to: 0)
        let fh6 = PeriodData(from: -1000, to: -500)
        
        let mil1 = PeriodData(from: 1000, to: 9999,periods:[fh2,fh1])
        let mil2 = PeriodData(from: 0, to: 1000,periods:[fh3,fh4])
        let mil3 = PeriodData(from: -1000, to: 0,periods:[fh5,fh6],timelineItem:true)
        
        var dataToPopulate = [mil3,mil2,mil1]
        
        savePeriodesFromCollection(dataToPopulate)
        

        var id = 1
        /*
        newEvent(id++,title: "King David conquers Jerusalem", year:-990, type:periodType.fivehundred)
        newEvent(id++,title:"First Olympiad in Greece", year:-776, type:periodType.fivehundred)
        newEvent(id++,title:"Rome founded by Romulus", year:-753, type:periodType.fivehundred)
        newEvent(id++,title:"Aesop’s fables thought to be written", year:-990, type:periodType.fivehundred)
        newEvent(id++,title:"Babylon ruled by Nebuchadnezzar", from: -605, to: -562, type:periodType.fivehundred)
        newEvent(id++,title:"Buddha born in India.", year:-563, type:periodType.fivehundred)
        newEvent(id++,title:"Confucius born in China", year:-551, type:periodType.fivehundred)
        newEvent(id++,title:"Roman calendar introduced", year:-535, type:periodType.fivehundred, text: "It had 10 months, with 304 days in a year that began in March.")
        */
        /*
        newEvent(id++,title:"Pythagoras describes his theorem", year:-532, type:periodType.fivehundred,text:"Pythagoras of Crotona describes the relations between sides of right-angled triangle, and tone vibrations.")
        newEvent(id++,title:"Rome as a Republic founded", year:-500, type:periodType.fivehundred, text:"End of monarchy in Rome")
        newEvent(id++,title:"Socrates drink hemlock", year:-399, type:periodType.fivehundred, text:"Socrates is required to drink hemlock to end his life after being found guilty of corrupting the youth of Athens")
        newEvent(id++,title:"Aristotle writes Meteorologica", year:-990, type:periodType.fivehundred,text: "The first book on weather.")
        newEvent(id++,title:"Persian empire", from:-550 , to:-330, type:periodType.fivehundred)
        newEvent(id++,title:"Alexander the Great rule Macedonia", from:-336 , to:-323, type:periodType.fivehundred)
        newEvent(id++,title:"Livius Andronicus is the first Roman poet", year:-240, type:periodType.fivehundred)
        
        newEvent(id++,title:"Archimedes explains principles of lever", year:-212, type:periodType.fivehundred, text:"Area of circle, principles of lever, the screw, and buoyancy.")
        newEvent(id++,title:"Eratosthenes determines the size of Earth", year:-194, type:periodType.fivehundred)
        newEvent(id++,title:"The Romans invade Britain", year:-55, type:periodType.fivehundred)
        newEvent(id++,title:"Rule of Cleopatra in Egypt", from:-51, to: -30, type:periodType.fivehundred)
        newEvent(id++,title:"Julius Caesar assassinated", year:-44, type:periodType.fivehundred)
        newEvent(id++,title:"Solomon builds the Temple in Jerusalem", year:-950, type:periodType.fivehundred)
        */
        /*
        newEvent(id++,title:"Tiberius becomes roman Emperor", year:14, type:periodType.hundred)
        newEvent(id++,title:"Nero becomes last Caesar", year:54, type:periodType.hundred)
        newEvent(id++,title:"First seismoscope developed in China", year:132, type:periodType.hundred)
        newEvent(id++,title:"Marcus Aurelius becomes emperor of Rome", year:161, type:periodType.hundred)
        newEvent(id++,title:"Emperor Commodus assisinated in Rome", year:193, type:periodType.hundred)
        newEvent(id++,title:"Founding of Constantinople", year:330, type:periodType.hundred)
        newEvent(id++,title:"Library of Alexandria is destroyed by fire", year:391, type:periodType.hundred)
        
        newEvent(id++,title:"Angles and Saxons conquer Britain", year:449, type:periodType.hundred)
        newEvent(id++,title:"Attila the Hun crosses the Rhine into Gaul", year:451, type:periodType.hundred)
        newEvent(id++,title:"Vandals conquer Rome", year:455, type:periodType.hundred)
        newEvent(id++,title:"Battle of Vouille", year:507, type:periodType.hundred, text:"Clovis, King of the Franks, defeats the Visigoths at the Battle of Vouille")
        newEvent(id++,title:"The plague of Europe", from:542, to:593, type:periodType.hundred)
        newEvent(id++,title:"The Lombards invade Italy", year:568, type:periodType.hundred)
        
        newEvent(id++,title:"Dagobert becomes King of the Franks", year:629, type:periodType.hundred)
        newEvent(id++,title:"Muhammad the Prophet dies", year:632, type:periodType.hundred)
        newEvent(id++,title:"Arabs destroy the city of Carthage", year:695, type:periodType.hundred, text:"Ending Byzantine rule in North Africa")
        newEvent(id++,title:"Moslem conquest of Spain", year:711, type:periodType.hundred)
        newEvent(id++,title:"Battle of Tours", year:732, type:periodType.hundred, text:"Frankish forces led by Charles Martel halt the Muslim advance into Europe")
        newEvent(id++,title:"First printed newspaper appears in Peking", year:748, type:periodType.hundred)
        
        newEvent(id++,title:"Battle of Atlakh", year:751, type:periodType.hundred, text: "Islamic army defeats the Chinese at the Battle of Atlakh, giving Muslims control of the Silk Road.")
        newEvent(id++,title:"Charlemagne becomes king of the Franks", year:771, type:periodType.hundred)
        newEvent(id++,title:"Charlemagne declares war against the Saxons in Germany", year:748, type:periodType.hundred)
        newEvent(id++,title:"Musa al-Kwarizmi born in Baghdad", year:780, type:periodType.hundred, text:"He introduced Hindu-Arabic numerals in his book Kitab al-jabr wa al-mugabalah.")
        newEvent(id++,title:"Vikings invade Ireland", year:795, type:periodType.hundred)
        newEvent(id++,title:"Charlemagne dies of pleurisy", year:814, type:periodType.hundred)
        newEvent(id++,title:"Toilet paper thought be used first in China", year:850, type:periodType.hundred)
        newEvent(id++,title:"Iceland discovered", year:861, type:periodType.hundred)
        newEvent(id++,title:"World’s first printed book ", year:868, type:periodType.hundred,text:"The world’s first printed book The Diamond Sutra is produced in China.")
        newEvent(id++,title:"Vikings settle in Iceland", year:874, type:periodType.hundred)
        newEvent(id++,title:"First record of an automatic instrument", year:890, type:periodType.hundred, text:"First record of an automatic instrument, an organ-building treatise called Banu Musa.")
        newEvent(id++,title:"Vikings discover Greenland", year:900, type:periodType.hundred)
        newEvent(id++,title:"Earliest recorded mention of playing cards, found in China.", year:969, type:periodType.hundred)
        newEvent(id++,title:"Mieczyslaw I becomes first ruler of Poland", year:960, type:periodType.hundred)
        newEvent(id++,title:"The Capetian dynasty", from:987 , to:1328, type:periodType.hundred)
        newEvent(id++,title:"Musical notation systematised.", year:990, type:periodType.hundred)
        
        newEvent(id++,title:"Leif Ericson lands in North America", year:1000, type:periodType.fifty, text: "The viking Leif Ericson lands in North America, calling it Vinland")
        newEvent(id++,title:"Paper money printed in China.", year:1023, type:periodType.fifty)
        newEvent(id++,title:"William the Conqueror invades England", year:1066, type:periodType.fifty,text:"William the Conqueror, from Normandy in France, invades England, defeats last Saxon king, Harold II, at Battle of Hastings")
        newEvent(id++,title:"Shen Kua of China writes about the magnetic compass", year:1086, type:periodType.fifty)
        newEvent(id++,title:"First modern university", year:1088, type:periodType.fifty, text: "First modern university established in Bologna, Italy")
        
        newEvent(id++,title:"Pope Urban II calls for holy war", year:1094, type:periodType.fifty,text:"At Council of Clermont, Pope Urban II calls for holy war to wrest Jerusalem from Muslims, launching the First Crusade the next year. Gilbert Crispin’s “A Friendly Disputation” published – a series of discussions on the opposing arguments of faiths between him and a Jew from Mainz.")
        newEvent(id++,title:"Crusaders capture Jerusalem", year:1099, type:periodType.fifty)
        newEvent(id++,title:"Chinese money printed in 3 colors to stop counterfeit", year:1107, type:periodType.fifty)
        newEvent(id++,title:"Henry V crowned Holy Roman Emperor", year:1111, type:periodType.fifty)
        newEvent(id++,title:"Knights Templar Order established in Jerusalem", year:1119, type:periodType.fifty)
        newEvent(id++,title:"Honorius II is elected pope", year:1124, type:periodType.fifty)
        newEvent(id++,title:"Second Crusade led by King Louis VIII", year:1145, type:periodType.fifty)
        newEvent(id++,title:"Moscow built by Prince Yuri Dolgoruky", year:1147, type:periodType.fifty)
        newEvent(id++,title:"The temple complex of Angkor Wat built", year:1150, type:periodType.fifty, text:"built by King Suryavarman II in Kampuchea (formerly Cambodia).")
        newEvent(id++,title:"Map of western China printed", year:1162, type:periodType.fifty, text:"Oldest known printed map")
        newEvent(id++,title:"Construction of the Leaning Tower of Pisa begins", year:1173, type:periodType.fifty,text:"Genghis Khan born")
        newEvent(id++,title:"Magnetic compass invented", year:1182, type:periodType.fifty,text:"The type of ore that attracted iron was known as magnesian stone because it was discovered in Magnesia in Asia Minor. The discovery of the magnet’s use in determining direction was made independently in China and Europe, the latter by English theologian and natural philosopher Alexander Neckam.")
        newEvent(id++,title:"Richard I becomes King of England", year:1189, type:periodType.fifty, text:"Known as Coeur de Lion or Richard the Lionheart")
        newEvent(id++,title:"The Louvre Museum in Paris built as a fortress", year:1190, type:periodType.fifty)
        newEvent(id++,title:"Buttons invented to decorate clothing", year:1200, type:periodType.fifty)
        newEvent(id++,title:"Genghis Khan captures Peking", year:1241, type:periodType.fifty)
        newEvent(id++,title:"Magna Carta signed by King John", year:1215, type:periodType.fifty,text:"The Great Charter, or Magna Carta, limiting royals power, signed and sealed by King John of England on 15 June at Runnymede, west of London near what is now Windsor. The Fourth Lateran Council recognized the doctrine of transubstantiation by which the bread and wine of the church service were seen as Christ’s flesh and blood.")
        newEvent(id++,title:"The Inquisition begins", year:1233, type:periodType.fifty)
        newEvent(id++,title:"University of Oxford founded", year:1249, type:periodType.fifty)
        newEvent(id++,title:"Gun invented in China", year:1250, type:periodType.fifty)
        newEvent(id++,title:"The flioria gold coins created in Florence", year:1252, type:periodType.fifty,text:"It would become the first international currency")
        newEvent(id++,title:"Marco Polo leaves Venice for China", year:1272, type:periodType.fifty,text:"Marco Polo leaves Venice for China, where he would live and prosper for 17 years, returning to Venice where he died in 1323")
        newEvent(id++,title:"University of Cambridge founded", year:1284, type:periodType.fifty)
        newEvent(id++,title:"The first mention of reading glasses", year:1286, type:periodType.fifty)
        
        newEvent(id++,title:"The Renaissance", from:1300, to:1600, type:periodType.fivehundred)
        
        newEvent(id++,title:"Robert the Bruce´s victory over the English", year:1314, type:periodType.fifty, text:"England bans football (soccer) because it’s too violent. Robert the Bruce leads the Scots to victory over the English at the Battle of Bannockburn")
        newEvent(id++,title:"The Hundred Years War", from:1337, to:1453, type:periodType.fivehundred,text:"The Hundred Years War begins between kings of England and France for control of France.")
        newEvent(id++,title:"The Black Death plague ", from:1346, to:1353, type:periodType.fifty,text:"Killing 25 million people, one third of the European population. The plague is a highly contagious fever caused by the bacillus Yersinia pestis, which is carried by fleas that infest rats.")
        newEvent(id++,title:"Drinking chocolate made by Aztecs", year:1350, type:periodType.fifty)
        newEvent(id++,title:"Leaning Tower of Pisa completed", year:1360, type:periodType.fifty)
        newEvent(id++,title:"Richard II made King of England", year:1377, type:periodType.fifty)
        newEvent(id++,title:"Joan of Arc born in France.", year:1412, type:periodType.fifty)
        newEvent(id++,title:"Joan of Arc leads French against English", year:1428, type:periodType.fifty)
        newEvent(id++,title:"Henry VI becomes King of England ", year:1429, type:periodType.fifty, text:"He is younger than a year old.")
        newEvent(id++,title:"Johannes Gutenberg prints the Bible", year:1450, type:periodType.fifty)
        newEvent(id++,title:"Leonardo da Vinci born", year:1452, type:periodType.fifty)
        newEvent(id++,title:"Wars of the Roses", from:1455, to:1487, type:periodType.fifty)
        newEvent(id++,title:"Ivan the Great first czar of Russia", year:1462, type:periodType.fifty)
        newEvent(id++,title:"Copernicus born in Poland", year:1473, type:periodType.fifty)
        newEvent(id++,title:"Michelangelo Buonarroti born", year:1475, type:periodType.fifty)
        newEvent(id++,title:"Columbus discovers the New World", year:1492, type:periodType.fifty)
        newEvent(id++,title:"Vasco da Gama discover sea route to India", year:1497, type:periodType.fifty)
        newEvent(id++,title:"First toothbrush made from hog bristles", year:1498, type:periodType.fifty)
        newEvent(id++,title:"World population 400 million", year:1500, type:periodType.fifty)
        newEvent(id++,title:"First flush toilets", year:1501, type:periodType.fifty)
        newEvent(id++,title:"Coiled springs invented", year:1502, type:periodType.fifty)
        newEvent(id++,title:"First handkerchief used in Europe", year:1503, type:periodType.fifty)
        newEvent(id++,title:"Balboa encounter the Pacific ocean", year:1513, type:periodType.fifty)
        newEvent(id++,title:"Copernicus suggests that the earth moves around the sun", year:1514, type:periodType.fifty)
        
        newEvent(id++,title:"Coffee from Arabia appears in Europe", year:1515, type:periodType.fifty)
        newEvent(id++,title:"Martin Luther begins the Reformation", year:1517, type:periodType.fifty)
        newEvent(id++,title:"Magellan starts his sail journey", year:1519, type:periodType.fifty)
        newEvent(id++,title:"Potato brought to Europe from South America", year:1540, type:periodType.fifty)
        newEvent(id++,title:"Ivan the Terrible (Ivan IV) crowned Czar", year:1547, type:periodType.fifty)
        newEvent(id++,title:"Mary Tudor becomes Queen of England", year:1554, type:periodType.fifty)
        newEvent(id++,title:"The pencil invented in England", year:1565, type:periodType.fifty)
        newEvent(id++,title:"Bottled beer invented in London.", year:1568, type:periodType.fifty)
        newEvent(id++,title:"Mary Queen of Scots executed", year:1587, type:periodType.fifty)
        newEvent(id++,title:"Kepler publishes Mysterium cosmographicum", year:1596, type:periodType.fifty)
        newEvent(id++,title:"The Union Jack adopted in England", year:1606, type:periodType.fifty)
        newEvent(id++,title:"First permanent English colony on American mainland", year:1607, type:periodType.fifty,text:"Jamestown, Virginia established, first permanent English colony on American mainland.")
        newEvent(id++,title:"Galileo Galilei discovers Jupiter’s 4 largest moons", year:1610, type:periodType.fifty)
        newEvent(id++,title:"The Thirty Years’ War", from:1618, to:1648, type:periodType.fifty, text:"War between Protestants and Catholics begins.")
        newEvent(id++,title:"The first mechanical calculator", year:1623, type:periodType.fifty, text:"German inventor Wilhelm Schickard invents the first mechanical calculator. Records detailing the machine’s workings were lost during the Thirty Years’ War.")
        
        newEvent(id++,title:"Buildig of Taj Mahal started", year:1632, type:periodType.fifty)

        newEvent(id++,title:"Inquisition forces Galileo to recant his belief", year:1633, type:periodType.fifty, text:"Inquisition forces Galileo to recant his belief in Copernican theory.")
        newEvent(id++,title:"The barometer is invented", year:1644, type:periodType.fifty, text:"Italian Evangelista Torricelli invents the barometer")
        newEvent(id++,title:"Descartes publishes Principles of Philosophy", year:1644, type:periodType.fifty)
        newEvent(id++,title:"Cromwell invades Ireland", year:1649, type:periodType.fifty)
        newEvent(id++,title:"Cromwell becomes ruler of England, Scotland and Ireland", year:1653, type:periodType.fifty)
        newEvent(id++,title:"Boyle develops Boyle’s Law", year:1662, type:periodType.fifty, text:"Boyle develops Boyle’s Law: the volume of a gas varies with its pressure")
        newEvent(id++,title:"Isaac Newton experiments with gravity", year:1664, type:periodType.fifty)
        
        newEvent(id++,title:"Fire destroys four-fifths of London", year:1666, type:periodType.fifty)
        newEvent(id++,title:"Hennig Brand discovers phosphorus", year:1000, type:periodType.fifty, text:"German alchemist Hennig Brand discovers phosphorus, the first new element found since ancient times")
        newEvent(id++,title:"A Paris cafe begins serving ice cream", year:1670, type:periodType.fifty)
        newEvent(id++,title:"Halley discovers Halley’s comet", year:1682, type:periodType.fifty)
        newEvent(id++,title:"Anthony van Leeuwenhoek discovers bacteria", year:1684, type:periodType.fifty,text:"he significance of which was not understood until the 19th century")
        newEvent(id++,title:"Gabriel Daniel Fahrenheit invents the thermometer", year:1686, type:periodType.fifty)
        newEvent(id++,title:"Mathematical Principles of Natural Philosophy published", year:1000, type:periodType.fifty, text:"Isaac Newton describes the theory of gravity. The era of modern physics is inaugurated by the publication of his Mathematical Principles of Natural Philosophy, commonly called the Principia’. It was published in Latin and did not appear in English until 1729.")
        newEvent(id++,title:"Peter the Great crowned Czar", year:1689, type:periodType.fifty)
        newEvent(id++,title:"Invention of steam pump", year:1698, type:periodType.fifty)
        newEvent(id++,title:"World population 700 million", year:1700, type:periodType.fifty)
        newEvent(id++,title:"Jethro Tull invents the seed drill", year:1701, type:periodType.fifty)
        newEvent(id++,title:"Act of Settlement in England", year:1701, type:periodType.fifty)
        newEvent(id++,title:"St Petersburg founded by Peter the Great", year:1703, type:periodType.fifty)
        newEvent(id++,title:"Act of Union between Scotland and England, creating Great Britain", year:1707, type:periodType.fifty)
        newEvent(id++,title:"Bartolomeo Cristofori invents the piano", year:1709, type:periodType.fifty)
        newEvent(id++,title:"George I becomes King of Britain", year:1714, type:periodType.fifty)
        newEvent(id++,title:"Louis XV becomes King of France", year:1715, type:periodType.fifty)
        newEvent(id++,title:"Firsk coffee planted in Brazil", year:1718, type:periodType.fifty)
        newEvent(id++,title:"Ketterer invents the cuckoo clock", year:1718, type:periodType.fifty)
        newEvent(id++,title:"Daniel Defoe publishes Robin Crusoe", year:1719, type:periodType.fifty)
        newEvent(id++,title:"South Sea Bubble", year:1720, type:periodType.fifty)
        newEvent(id++,title:"The first eraser put on the end of a pencil", year:1752, type:periodType.fifty)
        newEvent(id++,title:"George III becomes King of Britain", year:1760, type:periodType.fifty)
        newEvent(id++,title:"First street lights in New York", year:1761, type:periodType.fifty)
        newEvent(id++,title:"Mozart tours Europe as 6-year-old prodigy", year:1762, type:periodType.fifty)
        newEvent(id++,title:" Catherine the Great becomes Czarina", year:1762, type:periodType.fifty)
        newEvent(id++,title:"James Hargreaves invents the Spinning Jenny", year:1764, type:periodType.fifty)
        newEvent(id++,title:"James Watt inventsw rotary steam engine", year:1765, type:periodType.fifty)
        newEvent(id++,title:"Stamp Act passed in Britain", year:1765, type:periodType.fifty)
        newEvent(id++,title:"Boston Tea Party act", year:1769, type:periodType.fifty)
        newEvent(id++,title:"Nicolas Cugnot builds the motorized carriage", year:1769, type:periodType.fifty)
        newEvent(id++,title:"James Cook discovers Australia", year:1770, type:periodType.fifty)
        newEvent(id++,title:"The United Colonies changes name to The United States", year:1774, type:periodType.fifty)
        newEvent(id++,title:"Georges Louis Lesage patents the electric telegraph", year:1774, type:periodType.fifty)
        newEvent(id++,title:"Alexander Cummings invents the flush toilet", year:1775, type:periodType.fifty)
        newEvent(id++,title:"Declaration of Independence by American colonies", year:1776, type:periodType.fifty)
        newEvent(id++,title:"Franz Mesmer uses hypnotism", year:1778, type:periodType.fifty, text:"It’s from his name we get the word mesmerized")
        newEvent(id++,title:"Elias Boudinot elected President of the US", year:1783, type:periodType.fifty)
        newEvent(id++,title:"Thomas Mifflin elected President of the US", year:1784, type:periodType.fifty)
        newEvent(id++,title:"Richard Henry Lee elected President of the US", year:1785, type:periodType.fifty)
        newEvent(id++,title:"Nathan Gorman elected President of the US", year:1786, type:periodType.fifty)
        newEvent(id++,title:"Arthur St. Clair elected as President of the US", year:1787, type:periodType.fifty)
        newEvent(id++,title:"Cyrus Griffin elected President of the US", year:1788, type:periodType.fifty)
        newEvent(id++,title:"The first US presidential election under the Constitution", year:1789, type:periodType.fifty)
        newEvent(id++,title:"George Washington elected US President", year:1789, type:periodType.fifty)
        newEvent(id++,title:"US Post Office established", year:1789, type:periodType.fifty)
        newEvent(id++,title:"French Revolution", from:1789, to:1799, type:periodType.fifty)
        newEvent(id++,title:"William Murdoch invents gas lighting", year:1792, type:periodType.fifty)
        newEvent(id++,title:"The first ambulance used in France", year:1792, type:periodType.fifty)
        newEvent(id++,title:"Paul I becomes Tsar of Russia", year:1792, type:periodType.fifty)
        newEvent(id++,title:"The first soft drink invented", year:1798, type:periodType.fifty)
        newEvent(id++,title:"Napoleon Bonaparte declares himself dictator of France", year:1799, type:periodType.fifty)
        newEvent(id++,title:"Alessandro Volta invents the battery", year:1799, type:periodType.fifty)
        
        newEvent(id++,title:"The population of the world is about one billion", year:1800, type:periodType.ten)
        newEvent(id++,title:"Napoleon crowns himself Emperor of France", year:1804, type:periodType.ten)
        newEvent(id++,title:"Richard Trevithick builds the steam locomotive.", year:1804, type:periodType.ten)
        newEvent(id++,title:"Battle of Trafalga", year:1805, type:periodType.ten)
        newEvent(id++,title:" First Oktoberfest", year:1810, type:periodType.ten,text:"Held in Bavaria as celebration of Ludwig I’s wedding on 27 October")
        newEvent(id++,title:"Wellington invades France", year:1813, type:periodType.ten)
        newEvent(id++,title:"Napoleon gives crown of Spain to Ferdinand", year:1813, type:periodType.ten)
        newEvent(id++,title:"Battle of Waterloo", year:1815, type:periodType.ten)
        newEvent(id++,title:"James Monroe elected US President", year:1816, type:periodType.ten)
        newEvent(id++,title:"John Quincy Adams elected US President", year:1824, type:periodType.ten)
        newEvent(id++,title:"Michael Faraday discovers benzene", year:1825, type:periodType.ten)
        newEvent(id++,title:"William Sturgeon invents the electromagnet", year:1825, type:periodType.ten)
        newEvent(id++,title:"Samuel Mory patents the internal combustion engine", year:1826, type:periodType.ten)
        newEvent(id++,title:"George Canning elected Prime Minister of Britain", year:1827, type:periodType.ten)
        newEvent(id++,title:"John Walker invents the modern matches", year:1827, type:periodType.ten)
        newEvent(id++,title:"Wellington becomes Prime Minister of Britain", year:1828, type:periodType.ten)
        newEvent(id++,title:"Andrew Jackson elected US President.", year:1828, type:periodType.ten)
        newEvent(id++,title:"Michael Faraday discovers electromagnetic induction", year:1831, type:periodType.ten)
        newEvent(id++,title:"Louis Braille invents the stereoscope", year:1832, type:periodType.ten)
        newEvent(id++,title:"Martin van Buren elected US President", year:1836, type:periodType.ten)
        newEvent(id++,title:"Franklin Beale invents the coin press", year:1836, type:periodType.ten)
        newEvent(id++,title:"John Deere patents a steel plow", year:1837, type:periodType.ten)
        newEvent(id++,title:"Samuel Morse introduces the Morse code", year:1837, type:periodType.ten)
        newEvent(id++,title:"John Tyler becomes US President", year:1841, type:periodType.ten)
        newEvent(id++,title:"Patent of the rubber band", year:1845, type:periodType.ten)
        newEvent(id++,title:"Gold discovered in California", year:1848, type:periodType.ten)
        newEvent(id++,title:"Baking powder invented", year:1849, type:periodType.ten)
        newEvent(id++,title:"Millard Fillmore becomes US President", year:1850, type:periodType.ten)
        newEvent(id++,title:"Rabbits introduced to Australia", year:1850, type:periodType.ten)
        
        newEvent(id++,title:"Beer first sold in glass bottles", year:1850, type:periodType.ten)
        newEvent(id++,title:"John Gorrie invents a refrigerating machine", year:1851, type:periodType.ten)
        newEvent(id++,title:"Levi Strauss begins making trousers", year:1853, type:periodType.ten)
        newEvent(id++,title:"James Buchanan elected US President", year:1856, type:periodType.ten)
        newEvent(id++,title:"Darwin publishes Origin of Species", year:1859, type:periodType.ten)
        newEvent(id++,title:"The American Civil War", from:1861, to:1865, type:periodType.ten)
        newEvent(id++,title:"Kingdom of Italy declared", year:1861, type:periodType.ten)
        newEvent(id++,title:"Richard J Gatling invents the machine gun", year:1861, type:periodType.ten)
        newEvent(id++,title:"Bismarck becomes Prime Minister of Germany", year:1862, type:periodType.ten)
        newEvent(id++,title:"Alessandro Volta demonstrated the electric pile or battery", year:1862, type:periodType.ten)
        newEvent(id++,title:"Red Cross established", year:1864, type:periodType.ten)
        newEvent(id++,title:"US abolishes slavery through the Thirteenth Amendment", year:1865, type:periodType.ten)
        newEvent(id++,title:"First Atlantic cable laid", year:1866, type:periodType.ten)
        newEvent(id++,title:"Karl Marx publishes Das Kapital", year:1867, type:periodType.ten)
        newEvent(id++,title:"Gladstone becomes Prime Minister in Britain", year:1868, type:periodType.ten)
        newEvent(id++,title:"Ulysses S Grant elected US President", year:1868, type:periodType.ten)
        newEvent(id++,title:"Suez Canal opens", year:1869, type:periodType.ten)

        newEvent(id++,title:"world’s first traffic light", year:1868, type:periodType.ten)
        newEvent(id++,title:"The first New York City subway line opens", year:1870, type:periodType.ten)
        newEvent(id++,title:"Franco-Prussian war", from:1870, to:1871, type:periodType.ten)
        newEvent(id++,title:"German Empire created at Versailles", year:1871, type:periodType.ten)
        newEvent(id++,title:"Leo Tolstoy writes Anna Karenina", year:1871, type:periodType.ten)
        newEvent(id++,title:"Oscar II becomes King of Sweden and Norway", year:1872, type:periodType.ten)
        newEvent(id++,title:"Benjamin Disraeli elected Prime Minister of Britain", year:1874, type:periodType.ten)
        newEvent(id++,title:"Victor Hugo published Les Miserables", year:1874, type:periodType.ten)
        newEvent(id++,title:"Joseph Glidden invents barbed wire fencing", year:1874, type:periodType.ten)
        newEvent(id++,title:"Electric dental drill patented by George Green", year:1875, type:periodType.ten)
        newEvent(id++,title:"Graham Bell patents the telephone", year:1876, type:periodType.ten)
        newEvent(id++,title:"Rutherford Hayes elected US President", year:1876, type:periodType.ten)
        newEvent(id++,title:"Battle of Little Big Horn", year:1876, type:periodType.ten)
        newEvent(id++,title:"Thomas Edison invents the phonograph", year:1877, type:periodType.ten)
        newEvent(id++,title:"Otto Lilienthal builds a working glider", year:1877, type:periodType.ten)
        newEvent(id++,title:"William Crookes invents cathode ray tube.", year:1879, type:periodType.ten)
        newEvent(id++,title:"William Glastone elected British Prime Minister", year:1880, type:periodType.ten)
        newEvent(id++,title:"James Garfield elected US President", year:1880, type:periodType.ten)
        newEvent(id++,title:"US President Garfield killed", year:1881, type:periodType.ten,text:"Chester Arthur becomes US President")
        newEvent(id++,title:"Steven Grover Cleveland elected US President.", year:1884, type:periodType.ten)
        newEvent(id++,title:"World’s first skyscraper", year:1885, type:periodType.ten, text:"10-storey Home Insurance office, built in Chicago")
        newEvent(id++,title:"Karl Benz build gasoline-powered car", year:1885, type:periodType.ten)
        newEvent(id++,title:"First set of contact lenses", year:1887, type:periodType.ten)
        newEvent(id++,title:"Herz produces the first man-made radio waves", year:1887, type:periodType.ten)
        newEvent(id++,title:"Coca-Cola label registered", year:1887, type:periodType.ten)
        newEvent(id++,title:"William Henry Harrison elected US President", year:1888, type:periodType.ten)
        newEvent(id++,title:"John Loud invents ballpoint pen", year:1888, type:periodType.ten)
        newEvent(id++,title:"Patent of the roll film camera, the Kodak", year:1888, type:periodType.ten)
        newEvent(id++,title:"Gladstone elected British Prime Minister", year:1892, type:periodType.ten)
        newEvent(id++,title:"Rudolph Diesel invents diesel engine", year:1892, type:periodType.ten)
        newEvent(id++,title:"New Zealand first country to give women the right to vote", year:1893, type:periodType.ten)
        newEvent(id++,title:"Nicholas II becomes Tsar of Russia", year:1894, type:periodType.ten)
        newEvent(id++,title:"Rontgen discovers x-rays", year:1894, type:periodType.ten)
        newEvent(id++,title:"World’s first minimum wage law", year:1894, type:periodType.ten,text:"New Zealand passes world’s first minimum wage law")
        newEvent(id++,title:"William McKinley elected US President", year:1896, type:periodType.ten)
        newEvent(id++,title:"JJ Thompson discovers the electron", year:1896, type:periodType.ten)
        newEvent(id++,title:"Second Boer War", from:1899, to:1902, type:periodType.fifty)
        newEvent(id++,title:"Planck describing quantum mechanics", year:1900, type:periodType.ten)
        newEvent(id++,title:"Orville Wright makes powered flight", year:1903, type:periodType.ten)
        newEvent(id++,title:"First Tour de France", year:1903, type:periodType.ten)
        newEvent(id++,title:"Harley-Davidson motorcycle company founded", year:1903, type:periodType.ten)
        newEvent(id++,title:"Teabags invented by Thomas Suillivan", year:1904, type:periodType.ten)
        newEvent(id++,title:"Roald Amundsen discovers the magnetic north pole", year:1905, type:periodType.ten)
        newEvent(id++,title:"William Kellogg invents cornflakes", year:1906, type:periodType.ten)
        newEvent(id++,title:"First blood transfusion", year:1907, type:periodType.ten)
        newEvent(id++,title:"Leo Baekeland discovers plastic", year:1907, type:periodType.ten)
        newEvent(id++,title:"First Ford Model T rolls out", year:1908, type:periodType.ten)
        newEvent(id++,title:"Einstein proposes quantum theory", year:1908, type:periodType.ten)
        newEvent(id++,title:"Louis Bleriot flies across the English Channel", year:1909, type:periodType.ten)
        newEvent(id++,title:"First commercially made color film", year:1909, type:periodType.ten)
        newEvent(id++,title:"Artificial silk stockings made in Germany", year:1910, type:periodType.ten)
        newEvent(id++,title:"Roald Amundsen reaches the South Pole", year:1910, type:periodType.ten)
        newEvent(id++,title:"Republic of China founded", year:1910, type:periodType.ten)
        newEvent(id++,title:"First crossword puzzle published in New York Journal", year:1912, type:periodType.ten)
        newEvent(id++,title:"The Titanic sinks", year:1912, type:periodType.ten)
        newEvent(id++,title:"World War I", from:1914, to:1918, type:periodType.fifty)
        newEvent(id++,title:"Woodrow Wilson is US president", from:1913, to:1921, type:periodType.ten)
        newEvent(id++,title:"Poison gas is used as a weapon", year:1915, type:periodType.ten, text:"Poison gas is used as a weapon in Ypres, Belgium by German forces.")
        newEvent(id++,title:"BMW founded", year:1917, type:periodType.ten)
        newEvent(id++,title:"Lenin leads the Russian revolution", year:1917, type:periodType.ten)
        newEvent(id++,title:"Wireless telephone is invented", year:1919, type:periodType.ten)
        newEvent(id++,title:"First non-stop flight across the Atlantic", year:1919, type:periodType.ten)
        newEvent(id++,title:"Tommy-gun is patented by John T Thompson", year:1920, type:periodType.fifty)
        newEvent(id++,title:"Jacob Schick patents the electric shaver", year:1923, type:periodType.ten)
        newEvent(id++,title:"First Winter Olympics at Chamonix", year:1924, type:periodType.ten)
        newEvent(id++,title:"Charles Lindbergh flies non-stop from New York to Paris", year:1927, type:periodType.ten)
        newEvent(id++,title:"Alexander Fleming discovers penicillin", year:1928, type:periodType.ten)
        newEvent(id++,title:"First Bubble Gum goes on sale in the US", year:1928, type:periodType.ten)
        newEvent(id++,title:"New York Stock Exchange crash", year:1929, type:periodType.ten)
        newEvent(id++,title:"First football World Cup", year:1930, type:periodType.ten)
        newEvent(id++,title:"James Chadwick discovers the neutron", year:1932, type:periodType.ten)
        newEvent(id++,title:"Prohibition in the United States", from:1920, to:1933, type:periodType.ten)
        newEvent(id++,title:"Adolf Hitler becomes leader of Germany", year:1933, type:periodType.ten)
        newEvent(id++,title:"Volkswagen Beetle is launched", year:1936, type:periodType.ten)
        newEvent(id++,title:"Heinrich Focke creates the first successful helicopter", year:1936, type:periodType.ten)
        newEvent(id++,title:"Golden Gate Bridge opens", year:1937, type:periodType.ten)
        newEvent(id++,title:"First artificial element, technetium, created", year:1937, type:periodType.ten)
        newEvent(id++,title:"Supermarket trolleys introduced in Oklahoma", year:1938, type:periodType.ten)
        newEvent(id++,title:"Maiden flight of pressurized airliner", year:00, type:periodType.ten, text:"Boeing Stratoliner")
        newEvent(id++,title:"World War II", from:1939, to:1945, type:periodType.fifty)
        newEvent(id++,title:"Nylon stocking introduced", year:1940, type:periodType.ten)
        newEvent(id++,title:"Japan’s attack on Pearl Harbor", year:1941, type:periodType.ten)
        newEvent(id++,title:"Allied D-Day landings at Normandy", year:1944, type:periodType.ten)
        newEvent(id++,title:"World’s first nuclear reactor", year:1946, type:periodType.ten, text:"Opened in the USSR")
        newEvent(id++,title:"First solid-body electric guitar is built by Les Paul", year:1947, type:periodType.ten)
        newEvent(id++,title:"Kalashnikov invents the AK-47", year:1947, type:periodType.ten)
        newEvent(id++,title:"Israel established", year:1948, type:periodType.ten)
        newEvent(id++,title:"NATO founded", year:1949, type:periodType.ten)
        newEvent(id++,title:"Republic of Ireland founded", year:1949, type:periodType.ten)
        newEvent(id++,title:"The first Emmy is awarded", year:1949, type:periodType.ten)
        newEvent(id++,title:"Chrysler introduces power steering", year:1951, type:periodType.ten)
        newEvent(id++,title:"US sends 4 monkeys into the stratosphere", year:1951, type:periodType.ten)
        newEvent(id++,title:"Velcro is patented", year:1951, type:periodType.ten)
        newEvent(id++,title:" Sony invents pocket-sized transistor radio", year:1952, type:periodType.ten)
        newEvent(id++,title:"Man reach summit of Mount Everes", year:1953, type:periodType.ten)
        newEvent(id++,title:"Queen Elizabeth II crowned", year:1953, type:periodType.ten)
        newEvent(id++,title:"Playboy magazine is launched", year:1953, type:periodType.ten)
        newEvent(id++,title:"Dr Watson discovers the structure of DNA.", year:1953, type:periodType.ten)
        newEvent(id++,title:"USSR launches the Sputnik satellite", year:1957, type:periodType.ten)
        newEvent(id++,title:"Danish toymakers launches Lego", year:1958, type:periodType.ten)
        newEvent(id++,title:"Skateboard invented", year:1958, type:periodType.ten)
        newEvent(id++,title:"NASA founded", year:1958, type:periodType.ten)
        newEvent(id++,title:"Fidel Castro takes power in Cuba", year:1959, type:periodType.ten)
        newEvent(id++,title:"The Beatles form", year:1959, type:periodType.ten)
        newEvent(id++,title:"Yuri Gagarin the first man in space", year:1961, type:periodType.ten)
        newEvent(id++,title:"Dow Corp invent silicone breast implants", year:1962, type:periodType.ten)
        newEvent(id++,title:"The Cuban crisis", year:1962, type:periodType.ten)
        newEvent(id++,title:"President John F Kennedy assassinated.", year:1963, type:periodType.ten)
        newEvent(id++,title:"Sikorsky becomes first woman in space", year:1963, type:periodType.ten)
        newEvent(id++,title:"Che Guevara is shot dead by Bolivian troops", year:1967, type:periodType.ten)
        newEvent(id++,title:"Bill Gates and Paul Allen use their first computer", year:1968, type:periodType.ten)
        newEvent(id++,title:"Seiko launches the quartz wristwatch", year:1967, type:periodType.ten)
        newEvent(id++,title:"First staging of the Superbowl", year:1967, type:periodType.ten)
        newEvent(id++,title:"Dr Martin Luther King assassinated", year:1968, type:periodType.ten)
        newEvent(id++,title:"Neil Armstrong is the first man on the moon", year:1969, type:periodType.ten)
        newEvent(id++,title:"Yasser Arafat becomes leader of PLO", year:1969, type:periodType.ten)
        newEvent(id++,title:"IBM introduces the floppy disk ", year:1970, type:periodType.ten)
        newEvent(id++,title:"Texas Instruments launches the pocket calculator", year:1972, type:periodType.ten)
        newEvent(id++,title:"Nike running shoes launched", year:1972, type:periodType.ten)
        newEvent(id++,title:"Watergate scandal", year:1973, type:periodType.ten)
        newEvent(id++,title:"Arab oil embargo brings Europe to its knees", year:1973, type:periodType.ten)
        newEvent(id++,title:"Gillette introduces the disposable razor", year:1974, type:periodType.ten)
        newEvent(id++,title:"GM introduces the catalytic converter", year:1974, type:periodType.ten)
        newEvent(id++,title:"IBM launches the laser printer", year:1975, type:periodType.ten)
        newEvent(id++,title:"Viking I lands on Mars", year:1976, type:periodType.ten)
        newEvent(id++,title:"Apple computers founded", year:1976, type:periodType.ten)
        newEvent(id++,title:"Apple II the first mass-produced home computer", year:1977, type:periodType.ten)
        newEvent(id++,title:"Star Wars debuts", year:1977, type:periodType.ten)
        newEvent(id++,title:"First arcade video game, Space Invaders", year:1978, type:periodType.ten)
        newEvent(id++,title:"Nuclear accident at Three Mile Island, Pennsylvania", year:1979, type:periodType.ten)
        newEvent(id++,title:"Russia invades Afghanistan", year:1979, type:periodType.ten)
        newEvent(id++,title:"Philips invents the CD", year:1980, type:periodType.ten)
        newEvent(id++,title:"John Lennon is shot by Mark Chapman", year:1980, type:periodType.ten)
        newEvent(id++,title:"IBM launches their PC", year:1981, type:periodType.ten)
        newEvent(id++,title:"PacMan hits the arcades", year:1981, type:periodType.ten)
        newEvent(id++,title:"Shuttle Columbia launched", year:1981, type:periodType.ten)
        newEvent(id++,title:"HIV virus identified", year:1983, type:periodType.ten)
        newEvent(id++,title:"First commercial cell phone call", year:1983, type:periodType.ten)
        newEvent(id++,title:"Farman discovers the hole in the ozone", year:1985, type:periodType.ten)
        newEvent(id++,title:"Sinclair introduces the battery-operated car", year:1985, type:periodType.ten)
        newEvent(id++,title:"Nuclear reactor explodes in Chernobyl, Ukraine", year:1986, type:periodType.ten)
        newEvent(id++,title:"The Space Shuttle Challenger disaster", year:1986, type:periodType.ten)
        newEvent(id++,title:"Soviet Union launches Mir space station", year:1986, type:periodType.ten)
        newEvent(id++,title:"World population reaches 5 billion", year:1987, type:periodType.ten)
        newEvent(id++,title:"Stock exchanges collapse on Black Monday", year:1987, type:periodType.ten)
        newEvent(id++,title:"US introduces the F-117 stealth fighter", year:1988, type:periodType.ten)
        newEvent(id++,title:"Exxon Valdes runs aground in Alaska", year:1989, type:periodType.ten)
        newEvent(id++,title:"Berlin Wall comes down", year:1989, type:periodType.ten)
        newEvent(id++,title:"Tim Berners-Lee develops the World Wide Web", year:1989, type:periodType.ten)
        newEvent(id++,title:"Gulf War erupts as NATO defends Kuwait", year:1990, type:periodType.ten)
        newEvent(id++,title:"Hubble space telescope launched", year:1990, type:periodType.ten)
        newEvent(id++,title:"End of the Soviet Union", year:1991, type:periodType.ten)
        newEvent(id++,title:"Roslin Institute in Scotland clones a sheep", year:1997, type:periodType.ten)
        newEvent(id++,title:"The Bosnian War", from:1992, to:1995, type:periodType.ten)
        newEvent(id++,title:"Soviet–Afghan War", from:1979, to:1989, type:periodType.fifty)
        newEvent(id++,title:"The Korean War", from:1950, to:1953, type:periodType.ten)
        //_?

        newEvent(id++,title:"Vietnam War", from:1954,to:1975, type:periodType.ten)
        newEvent(id++,title:"World population reaches the 6 billion mark", year:1999, type:periodType.ten)
        
        newEvent(id++,title:"Vladimir Putin elected President of Russia", year:2000, type:periodType.ten)
        newEvent(id++,title:"George W Bush defeats Al Gore to become US President", year:2000, type:periodType.ten)
        
        
        
        newEvent(id++,title:"Wikipedia started", year:2001, type:periodType.ten)
        newEvent(id++,title:"September 11", year:2001, type:periodType.ten)
        newEvent(id++,title:"Euro banknotes and coins released", year:2002, type:periodType.ten)

        newEvent(id++,title:"Space Shuttle Columbia disintegrates over Texas", year:2003, type:periodType.ten)
        newEvent(id++,title:"Facebook founded", year:2004, type:periodType.ten)
        newEvent(id++,title:"YouTube launched", year:2005, type:periodType.ten)
        newEvent(id++,title:"Apple launches the iPhone", year:2007, type:periodType.ten)
        newEvent(id++,title:"Dmitri Medvedev elected President of Russia", year:2008, type:periodType.ten)
        newEvent(id++,title:"", year:00, type:periodType.ten)
*/
        
        /*
        newEvent(id++,title:"war (1918-1939)", from: 1918, to:1939, type:periodType.fifty,level: 1)
        newEvent(id++,title:"Test between (1918-1960)", from: 1918, to:1960, type:periodType.fifty,text:"First record of an automatic instrument, an organ-building treatise called Banu Musa. First record of an automatic instrument, an organ-building treatise called Banu Musa.",level: 2)
        newEvent(id++,title:"Someone is born (1751)", year: 1751, type:periodType.fifty,level:2)
        newEvent(id++,title:"old war (1918-1939)", from: -540, to:-300, type:periodType.fivehundred, text:"The best approach to add padding to a UILabel is to subclass UILabel and add an edgeInsets property. You then set the desired insets and the label will be drawn accordingly.",level: 3)
*/

        newEvent(id++,title:"World population reaches the 6 billion mark", year:1999, type:periodType.ten)
        newEvent(id++,title:"Dmitri Medvedev elected President of Russia", year:2008, type:periodType.ten)
        newEvent(id++,title:"Confucius born in China", year:-551, type:periodType.fivehundred)
        println("populated new data")

        save()
        
        dataPopulatedID = 1
        saveGameData()
        
        completePopulating?()
    }
    
    func newEvent(idForUpdate:Int,title:String, from: Int, to:Int, type:periodType, text:String = "", level:Int = 4, tags:String = "")
    {
        let q1 = HistoricEvent.createInManagedObjectContext(self.managedObjectContext!,idForUpdate:idForUpdate,  title:title, from: from, to:to, text:text, level:level)
        hookQuestionToPeriods(q1,type: type)
    }
    
    func newEvent(idForUpdate:Int,title:String, year: Int, type:periodType, text:String = "", level:Int = 4, tags:String = "")
    {
        let q1 = HistoricEvent.createInManagedObjectContext(self.managedObjectContext!,idForUpdate:idForUpdate,  title:title, year:year, text:text,level:level)
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
            if periodData.from == 1000 && periodData.to == 1500
            {
                let h = 0
            }
            
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
            if let err = error
            {
                println(err.localizedDescription)

            }
        }
    }
    
    func fetchData(fromLevel:Int,toLevel:Int) {

        // Create a new fetch request using the LogItem entity
        // eqvivalent to select * from Relation
        let fetchEvents = NSFetchRequest(entityName: "HistoricEvent")
        
        //let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
        //fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        //let predicate = NSPredicate(format: "titlenumber contains %@", "Worst")
        // Set the predicate on the fetch request
        let predicate = NSPredicate(format: "periods.@count > 0 AND level >= \(fromLevel) AND level <= \(toLevel)")
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
    let OkScoreKey = "OkScore"
    let GoodScoreKey = "GoodScore"
    let LoveScoreKey = "LoveScore"
    let TagsKey = "Tags"
    let LevelKey = "Level"
    let EventsUpdateKey = "EventsUpdate"
    
    var dataPopulatedID:AnyObject = 0
    var okScoreID:AnyObject = 0
    var goodScoreID:AnyObject = 0
    var loveScoreID:AnyObject = 0
    var tagsID:AnyObject = 0
    var levelID:AnyObject = 0
    var eventsUpdateID:AnyObject = 0

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
            tagsID = dict.objectForKey(TagsKey)!
            levelID = dict.objectForKey(LevelKey)!
            eventsUpdateID = dict.objectForKey(EventsUpdateKey)!
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
        dict.setObject(tagsID, forKey: TagsKey)
        dict.setObject(levelID, forKey: LevelKey)
        dict.setObject(eventsUpdateID, forKey: EventsUpdateKey)
        //writing to GameData.plist
        dict.writeToFile(path, atomically: false)
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        println("Saved GameData.plist file is --> \(resultDictionary?.description)")
    }
    
    func getMaxTimeLimit(year: Double) -> Double
    {
        return year > todaysYear ? todaysYear : year
    }
}


