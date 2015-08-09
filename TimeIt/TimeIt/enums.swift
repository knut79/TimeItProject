//
//  enums.swift
//  TimeIt
//
//  Created by knut on 12/07/15.
//  Copyright (c) 2015 knut. All rights reserved.
//



enum periodType: Int
{
    case millenia = 1000
    case fivehundred = 500
    case hundred = 100
    case fifty = 50
    case ten = 10
    case five = 5
    case unvalid = 0
    
    var description: String {
        switch self {
        case .millenia:
            return "1000"
        case .fivehundred:
            return "500"
        case .hundred:
            return "100"
        case .fifty:
            return "50"
        case .ten:
            return "10"
        case .five:
            return "5"
        default:
            return "not valid"
        }
    }
    
    var years: Int {
        switch self {
        case .millenia:
            return 1000
        case .fivehundred:
            return 500
        case .hundred:
            return 100
        case .fifty:
            return 50
        case .ten:
            return 10
        case .five:
            return 5
        default:
            return 0
        }
    }
}


enum eventType: Int
{
    case singleYear = 0,periode
}