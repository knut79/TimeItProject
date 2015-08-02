//
//  BackgroundPopulateData.swift
//  TimeIt
//
//  Created by knut on 25/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//

import Foundation

class BackgroundPopulateData: NSOperation {
    override func main() -> (){
        DataHandler().populateData()
    }
}
