//
//  DayOfWeeks.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

enum DayOfWeeks : Int, CustomStringConvertible {
    case Monday = 2, Tuesday = 3, Wednesday = 4, Thursday = 5, Friday = 6, Saturday = 7, Sunday = 1, None = 0
    
    var description: String {
        get {
            switch self {
            case .Monday:
                return "Mon"
            case .Tuesday:
                return "Tue"
            case .Wednesday:
                return "Wed"
            case .Thursday:
                return "Thu"
            case .Friday:
                return "Fri"
            case .Saturday:
                return "Sat"
            case .Sunday:
                return "Sun"
            case .None:
                return "Not a day of the week."
            }
        }
        
    }
}