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
    
    public init(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, millisecond: Int? = nil, kind: DateTimeKind = .Local)
    {
        let component = NSDateComponents()
        var timeZone: String? = nil
        var d: Int? = nil
        var ns: Int? = nil
        if kind == .Utc
        {
            timeZone = "UTC"
        }
        
        let y = Math.MoveToRange(x: year, min: 1, max: 9999)
        //comp.year = movedYear
        let m = Math.MoveToRange(x: month, min: 1, max: 12)
        //comp.month = movedMonth

        if y != nil && m != nil {
            d = Math.MoveToRange(x: day, min: 1, max: Date.DaysInMonth(year: y!, month: m!)!)
        }
        if millisecond != nil {
            ns = (millisecond! * Date.NANOSECONDS_IN_MILLISECOND)
        }
        
        _date = component.nSDateFromComponents(
            year: y,
            month: m,
            day: d,
            hour: Math.MoveToRange(x: hour, min: 0, max: 23),
            minute: Math.MoveToRange(x: minute, min: 0, max: 59),
            second: Math.MoveToRange(x: second, min: 0, max: 59),
            nanosecond: ns,
            timeZone: timeZone)
        _kind = kind
    }
    
    public init(nsdate: NSDate, kind: DateTimeKind = .Local) {
        _date = nsdate
        _kind = kind
    }
}

//MARK: PUBLIC DATETIME GETTERS PROPERTIES
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
    
    /**
    Read-only: the kind of the date
     - Returns: DateTimeKind
        - Values: **Utc, Local, Unspecified**
    */
    public var Kind: DateTimeKind    { return _kind }
    
    /**
    Read-only: the NSDate core type
     - Returns: **original** NSDate object (will mutate the original Date object)
    */
    public var AsDate: NSDate? { return _date }
    
    /**
    Read-only: the NSDate core type
     - Returns: **copy** NSDate object
    */
    public var ToNSDate: NSDate? {
//        components
        let component = NSCalendar.currentCalendar().components(Date.componentFlags(), fromDate: _date!)
        return component.nSDateFromComponents(
            year: component.year,
            month: component.month,
            day: component.day,
            hour: component.hour,
            minute: component.minute,
            second: component.second,
            nanosecond: component.nanosecond,
            timeZone: component.timeZone!.abbreviation
            )
    }
    
}

public extension Date
{
    static func DaysInMonth(year year : Int? = nil, month : Int? = nil) -> Int? {
        if year == nil || month == nil { return nil }
        let comp = NSDateComponents()
        comp.year = Math.MoveToRange(x: year!, min: 1, max: 9999)!
        comp.month = Math.MoveToRange(x: month!, min: 0, max: 12)!
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

internal extension NSDateComponents {
    
    internal func nSDateFromComponents(year year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, timeZone: String? = nil) -> NSDate!
    {
        if year != nil { self.year = year! }
        if month != nil { self.month = month! }
        if day != nil { self.day = day! }
        if hour != nil { self.hour = hour! }
        if minute != nil { self.minute = minute! }
        if second != nil { self.second = second! }
        if nanosecond != nil { self.nanosecond = nanosecond! }
        self.timeZone = (timeZone != nil ? NSTimeZone(abbreviation: timeZone!) : NSTimeZone.defaultTimeZone())
        
        // Set weekday stuff to undefined to prevent dateFromComponents to get confused
        self.yearForWeekOfYear = NSDateComponentUndefined
        self.weekOfYear = NSDateComponentUndefined
        self.weekday = NSDateComponentUndefined
        self.weekdayOrdinal = NSDateComponentUndefined
        
        // Set calendar time zone to desired time zone
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = self.timeZone!
        
        return calendar.dateFromComponents(self)
    }
}