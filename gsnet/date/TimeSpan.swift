//
//  TimeSpan.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public struct TimeSpan {
    private var _ticks: Double {
        get { return self.getTicksFromUnits(days: _days, hours: _hours, minutes: _minutes, seconds: _seconds, milliseconds: _milliseconds, nanoseconds: _nanoseconds)
        }
    }
    
    private var _days: Double = 0
    private var _hours: Double = 0
    private var _minutes: Double = 0
    private var _seconds: Double = 0
    private var _milliseconds: Double = 0
    private var _nanoseconds: Double = 0
    
    public init(interval: NSTimeInterval){
        self.popullateUnits(ticks: interval)
    }
    
    public init(days: Double = 0, hours: Double = 0, minutes: Double = 0, seconds: Double = 0, milliseconds: Double = 0, nanoseconds: Double = 0){
        self.popullateUnits(ticks: getTicksFromUnits(days: days, hours: hours, minutes: minutes, seconds: seconds, milliseconds: milliseconds, nanoseconds: nanoseconds))
    }
    
}

//MARK: PUBLIC TIMESPAN READONLY PROPERTIES

public extension TimeSpan {
    
    public var Days: Double {
        return _days
    }
    
    public var Hours: Double {
        return _hours
    }
    
    public var Minutes: Double {
        return _minutes
    }
    
    public var Seconds: Double {
        return _seconds
    }
    
    public var Milliseconds: Double {
        return _milliseconds
    }
    
    public var Nanoseconds: Double {
        return _nanoseconds
    }
    
    public var Interval: NSTimeInterval {
        return _ticks
    }
    
    public var TotalSeconds: Double {
        return self.Interval
    }
    
    public var TotalMinutes: Double {
        return self.Interval / TimeSpan.TICKS_IN_MINUTE
    }
    
    public var TotalHours: Double {
        return self.Interval / TimeSpan.TICKS_IN_HOUR
    }
    
    public var TotalDays: Double {
        return self.Interval / TimeSpan.TICKS_IN_DAY
    }
}

//MARK: PUBLIC TIMESPAN INSTANCE METHODS

public extension TimeSpan {
    public func Add(timeSpan: TimeSpan) -> TimeSpan {
        return TimeSpan(interval: self.Interval + timeSpan.Interval)
    }
    
    
    public func Duration() -> TimeSpan {
        return TimeSpan(interval: Math.Abs(self.Interval))
    }
    
    public func Negate() -> TimeSpan {
        return TimeSpan(interval: self.Interval * -1)
    }
    
    public func Subtruct(timeSpan: TimeSpan) -> TimeSpan {
        return TimeSpan(interval: self.Interval - timeSpan.Interval)
    }
}

//MARK: PUBLIC TIMESPAN STATIC METHODS 

public extension TimeSpan {
    public static func FromDays(days: Double) -> TimeSpan {
        return TimeSpan(days: days)
    }
    
    public static func FromHours(hours: Double) -> TimeSpan {
        return TimeSpan(hours: hours)
    }
    
    public static func FromMinutes(minutes: Double) -> TimeSpan {
        return TimeSpan(minutes: minutes)
    }
    
    public static func FromSeconds(seconds: Double) -> TimeSpan {
        return TimeSpan(seconds: seconds)
    }
    
    public static func FromInterval(interval: NSTimeInterval) -> TimeSpan {
        return TimeSpan(interval: interval)
    }
    
    public static func Parse(interval: String) -> TimeSpan? {
        if let ticks = Double(interval) {
            return TimeSpan(interval: ticks)
        } else {
            return nil
        }
    }
}

//MARK: PUBLIC TIMESPAN MUTATING METHODS

public extension TimeSpan {

}

//MARK: PUBLIC TIMESPAN CONSTANTS

public extension TimeSpan {
    internal static let NANOSECONDS_IN_MILLISECOND: Double = 1000000
    internal static let MILLISECONDS_IN_SECOND: Double = 1000
    internal static let SECONDS_IN_MINUTE: Double = 60
    internal static let MINUTES_IN_HOUR: Double = 60
    internal static let HOURS_IN_DAY: Double = 24
    
    public static let TICKS_IN_SECOND: Double = 1
    public static let TICKS_IN_MINUTE: Double = TimeSpan.TICKS_IN_SECOND * TimeSpan.SECONDS_IN_MINUTE
    public static let TICKS_IN_HOUR: Double = TimeSpan.TICKS_IN_MINUTE * TimeSpan.MINUTES_IN_HOUR
    public static let TICKS_IN_DAY: Double = TimeSpan.TICKS_IN_HOUR * TimeSpan.HOURS_IN_DAY
    public static let TICKS_IN_MILLISECOND: Double = TimeSpan.TICKS_IN_SECOND / TimeSpan.MILLISECONDS_IN_SECOND
    public static let TICKS_IN_NANOSECOND: Double = TimeSpan.TICKS_IN_MILLISECOND / TimeSpan.NANOSECONDS_IN_MILLISECOND
}

//MARK: PRIVATE TIMESPAN HELPER METHODS

private extension TimeSpan {
    private static func GetUnitsAndReminder(value: Double, devisionUnit: Double) -> (whole:Double, reminder:Double) {
        let whole = trunc(value / devisionUnit)
        let reminder = value % devisionUnit
        return (whole, reminder)
    }
    
    private mutating func popullateUnits(ticks ticks: Double) {
        let days = TimeSpan.GetUnitsAndReminder(ticks, devisionUnit: TimeSpan.TICKS_IN_DAY)
        _days = days.whole
        let hours = TimeSpan.GetUnitsAndReminder(days.reminder, devisionUnit: TimeSpan.TICKS_IN_HOUR)
        _hours = hours.whole
        let minutes = TimeSpan.GetUnitsAndReminder(hours.reminder, devisionUnit: TimeSpan.TICKS_IN_MINUTE)
        _minutes = minutes.whole
        let seconds = TimeSpan.GetUnitsAndReminder(minutes.reminder, devisionUnit: TimeSpan.TICKS_IN_SECOND)
        _seconds = seconds.whole
        let milliseconds = TimeSpan.GetUnitsAndReminder(seconds.reminder, devisionUnit: TimeSpan.TICKS_IN_MILLISECOND)
        _milliseconds = milliseconds.whole
        let nanoseconds = TimeSpan.GetUnitsAndReminder(milliseconds.reminder, devisionUnit: TimeSpan.TICKS_IN_NANOSECOND)
        _nanoseconds = nanoseconds.whole
    }
    
    private func getTicksFromUnits(days days: Double = 0, hours: Double = 0, minutes: Double = 0, seconds: Double = 0, milliseconds: Double = 0, nanoseconds: Double = 0) -> Double {
        return days * TimeSpan.TICKS_IN_DAY
            + hours * TimeSpan.TICKS_IN_HOUR
            + minutes * TimeSpan.TICKS_IN_MINUTE
            + seconds * TimeSpan.TICKS_IN_SECOND
            + milliseconds * TimeSpan.TICKS_IN_MILLISECOND
            + nanoseconds * TimeSpan.TICKS_IN_NANOSECOND
    }
}

//MARK: ARITHMETICS OVERLOADS

public func +(left: TimeSpan, right: TimeSpan) -> TimeSpan {
    return TimeSpan(interval: left.Interval + right.Interval)
}

public func -(left: TimeSpan, right: TimeSpan) -> TimeSpan {
    return TimeSpan(interval: left.Interval - right.Interval)
}

public func *(left: TimeSpan, right: Double) -> TimeSpan {
    return TimeSpan(interval: left.Interval * right)
}

public func *(left: Double, right: TimeSpan) -> TimeSpan {
    return TimeSpan(interval: left * right.Interval)
}

public func /(left: TimeSpan, right: TimeSpan) -> Double {
    return Double(left.Interval / right.Interval)
}

public func /(left: TimeSpan, right: Double) -> TimeSpan {
    return TimeSpan(interval: left.Interval / right)
}

//MARK: EQUATABLE IMPLEMENTATION
extension TimeSpan : Equatable {}

public func ==(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Interval == right.Interval)
}

public func !=(left: TimeSpan, right: TimeSpan) -> Bool {
    return !(left.Interval == right.Interval)
}

//MARK: COMPARABLE IMPLEMENTATION
extension TimeSpan: Comparable {}

public func <(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Interval < right.Interval)
}

public func >(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Interval > right.Interval)
}

public func <=(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Interval <= right.Interval)
}

public func >=(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Interval >= right.Interval)
}

//MARK: ARITHMENTICS

prefix func -(timeSpan: TimeSpan) -> TimeSpan {
    return TimeSpan(interval: -timeSpan.Interval)
}

func +=(inout left: TimeSpan, right: TimeSpan) {
    left = left + right
}

func -=(inout left: TimeSpan, right: TimeSpan) {
    left = left - right
}

func *=(inout left: TimeSpan, right: Double) {
    left = left * right
}

func /=(inout left: TimeSpan, right: Double) {
    left = left / right
}
