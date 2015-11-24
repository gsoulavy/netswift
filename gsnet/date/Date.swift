//
//  DateTime.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import Foundation


public struct Date
{
    private var _date: NSDate?
    private var _kind: DateTimeKind = .Unspecified
    
    public init(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, millisecond: Int = 0, kind: DateTimeKind = DateTimeKind.Local) {
        let cal = NSCalendar.currentCalendar()
        let comp = NSDateComponents()
        if kind == .Utc { comp.timeZone = NSTimeZone(abbreviation: "UTC") }
        let movedYear = Math.MoveToRange(x: year, min: 1, max: 9999)
        comp.year = movedYear
        let movedMonth = Math.MoveToRange(x: month, min: 1, max: 12)
        comp.month = movedMonth
        comp.day = Math.MoveToRange(x: day, min: 1, max: Date.DaysInMonth(year: movedYear, month: movedMonth))
        comp.hour = Math.MoveToRange(x: hour, min: 0, max: 23)
        comp.minute = Math.MoveToRange(x: minute, min: 0, max: 59)
        comp.second = Math.MoveToRange(x: second, min: 0, max: 59)
        comp.nanosecond = (millisecond * Date.NANOSECONDS_IN_MILLISECOND)
        _date = cal.dateFromComponents(comp)
        _kind = kind
    }
}

//MARK: PUBLIC DATETIME PROPERTIES
public extension Date
{
    /// Get the year component of the date
    public var Year : Int			{ return components.year }
    /// Get the month component of the date
    public var Month : Int			{ return components.month }
    /// Get the week of the month component of the date
    var WeekOfMonth: Int	{ return components.weekOfMonth }
    /// Get the week of the month component of the date
    var WeekOfYear: Int		{ return components.weekOfYear }
    /// Get the weekday component of the date
    var Weekday: Int		{ return components.weekday }
    /// Get the weekday ordinal component of the date
    var WeekdayOrdinal: Int	{ return components.weekdayOrdinal }
    /// Get the day component of the date
    var Day: Int			{ return components.day }
    /// Get the hour component of the date
    var Hour: Int			{ return components.hour }
    /// Get the minute component of the date
    var Minute: Int			{ return components.minute }
    /// Get the second component of the date
    var Second: Int			{ return components.second }
    /// Get the millisecond component of the Date
    var Millisecond: Int    { return components.nanosecond / Date.NANOSECONDS_IN_MILLISECOND }
    /// Get the era component of the date
    var Era: Int			{ return components.era }
    /// Get the current month name based upon current locale
    var MonthName: String {
        let dateFormatter = Date.localThreadDateFormatter()
        dateFormatter.locale = NSLocale.autoupdatingCurrentLocale()
        return dateFormatter.monthSymbols[Month - 1] as String
    }
    /// Get the current weekday name
    var WeekdayName: String {
        let dateFormatter = Date.localThreadDateFormatter()
        dateFormatter.locale = NSLocale.autoupdatingCurrentLocale()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        return dateFormatter.stringFromDate(_date!)
    }
}

public extension Date
{
    static func DaysInMonth(year year : Int, month : Int) -> Int {
        let comp = NSDateComponents()
        comp.year = Math.MoveToRange(x: year, min: 1, max: 9999)
        comp.month = Math.MoveToRange(x: month, min: 0, max: 12)
        let cal = NSCalendar.currentCalendar()
        let nsdate = cal.dateFromComponents(comp)
        let days = cal.rangeOfUnit(.Day, inUnit: .Month, forDate: nsdate!)
        return days.length
    }
}

//MARK: INTERNAL DATETIME CONSTANTS
internal extension Date
{
    internal static let NANOSECONDS_IN_MILLISECOND: Int = 1000000
}

internal extension Date
{
    
}

//MARK: PRIVATE DATETIME MEMBERS
private extension Date
{
    
    private static func componentFlags() -> NSCalendarUnit {
        return [.Era ,
            .Year ,
            .Month ,
            .Day,
            .WeekOfYear,
            .Hour ,
            .Minute ,
            .Second ,
            .Nanosecond,
            .Weekday ,
            .WeekOfMonth ,
            .WeekdayOrdinal,
            .WeekOfYear]
    }
    
    private func addComponents(components: NSDateComponents) -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingComponents(components, toDate: _date!, options: [])
    }
    
    /// Return the NSDateComponents which represent current date
    private var components: NSDateComponents {
        return  NSCalendar.currentCalendar().components(Date.componentFlags(), fromDate: _date!)
    }
    
    /**
     This function uses NSThread dictionary to store and retrive a thread-local object, creating it if it has not already been created
     
     :param: key    identifier of the object context
     :param: create create closure that will be invoked to create the object
     
     :returns: a cached instance of the object
     */
    private static func cachedObjectInCurrentThread<T: AnyObject>(key: String, create: () -> T) -> T {
        if let threadDictionary = NSThread.currentThread().threadDictionary as NSMutableDictionary? {
            if let cachedObject = threadDictionary[key] as! T? {
                return cachedObject
            } else {
                let newObject = create()
                threadDictionary[key] = newObject
                return newObject
            }
        } else {
            assert(false, "Current NSThread dictionary is nil. This should never happens, we will return a new instance of the object on each call")
            return create()
        }
    }
    
    /**
     Return a thread-cached NSDateFormatter instance
     
     :returns: instance of NSDateFormatter
     */
    private static func localThreadDateFormatter() -> NSDateFormatter {
        
        return Date.cachedObjectInCurrentThread("com.library.swiftdate.dateformatter") {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return dateFormatter
        }
    }
}