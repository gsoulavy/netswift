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
    private var _date: NSDate
    private var _components: NSDateComponents
    private var _kind: DateTimeKind = .Unspecified
    
    public init(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, millisecond: Int? = nil, kind: DateTimeKind = .Local)
    {
        var d: Int? = nil
        var ns: Int? = nil
        let y = Math.MoveToRange(x: year, min: 1, max: 9999)
        let m = Math.MoveToRange(x: month, min: 1, max: 12)

        if y != nil && m != nil
        {
            d = Math.MoveToRange(x: day, min: 1, max: Date.DaysInMonth(year: y!, month: m!)!)
        }
        if millisecond != nil
        {
            ns = (millisecond! * Date.NANOSECONDS_IN_MILLISECOND)
        }
        _components = NSDateComponents()
        _date = _components.nSDateFromComponents(
            year: y,
            month: m,
            day: d,
            hour: Math.MoveToRange(x: hour, min: 0, max: 23),
            minute: Math.MoveToRange(x: minute, min: 0, max: 59),
            second: Math.MoveToRange(x: second, min: 0, max: 59),
            nanosecond: ns,
            timeZone: Date.dateTimeKindToNSTimeZone(kind))
        _kind = kind
    }
    
    public init(nsdate: NSDate, kind: DateTimeKind = .Local) {
        let timeZone: NSTimeZone = Date.dateTimeKindToNSTimeZone(kind)
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = timeZone
        _date = nsdate
        _kind = kind
        _components = calendar.componentsInTimeZone(timeZone, fromDate: _date)
    }
    
    public init(ticks: Double, kind: DateTimeKind = .Local) {
        let timeZone: NSTimeZone = Date.dateTimeKindToNSTimeZone(kind)
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = timeZone
        _date = NSDate(timeIntervalSinceReferenceDate: ticks)
        _kind = kind
        _components = calendar.componentsInTimeZone(timeZone, fromDate: _date)
    }
}

//MARK: PUBLIC DATETIME GETTERS PROPERTIES
public extension Date
{
    /// Get the year component of the date
    public var Year : Int			{ return Components.year }
    /// Get the month component of the date
    public var Month : Int			{ return Components.month }
    /// Get the week of the month component of the date
    var WeekOfMonth: Int	{ return Components.weekOfMonth }
    /// Get the week of the month component of the date
    var WeekOfYear: Int		{ return Components.weekOfYear }
    /// Get the weekday component of the date
    var Weekday: Int		{ return Components.weekday }
    /// Get the weekday ordinal component of the date
    var WeekdayOrdinal: Int	{ return Components.weekdayOrdinal }
    /// Get the day component of the date
    var Day: Int			{ return Components.day }
    /// Get the hour component of the date
    var Hour: Int           { return Components.hour }
    /// Get the minute component of the date
    var Minute: Int			{ return Components.minute }
    /// Get the second component of the date
    var Second: Int			{ return Components.second }
    /// Get the millisecond component of the Date
    var Millisecond: Int    { return Components.nanosecond / Date.NANOSECONDS_IN_MILLISECOND }
    /// Get the era component of the date
    var Era: Int			{ return Components.era }
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
        return dateFormatter.stringFromDate(_date)
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
        
        return _date.copy() as? NSDate
    }
    
    /**
    Read-only: Double ticks since reference (**2001-01-01**)
     - Returns: Double in second
    */
    public var Ticks: Double {
        return _date.timeIntervalSinceReferenceDate
    }
    
    public var TicksEpoch: Double {
        return _date.timeIntervalSince1970
    }
    
    /**
     Read-only: Int ticks since fileTime zero (**0001-01-01**)
     - Returns: Int
     */
    public var FileTimeTicks: Int {
        return Int(self.Ticks) * Date.TICKSINSECOND + Date.TICKS_BETWEEN_REFERENCEZERO_AND_DATETIMEZERO_IN_MILLISECONDS
    }
    
    /**
     Read-only: Returns NSDateComponent belonging to Date
     - Returns: NSDateComponent
     */
    public var Components: NSDateComponents {
        return _components
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
    internal static let TICKSINSECOND: Int = 1000
    internal static let NANOSECONDS_IN_MILLISECOND: Int = 1000000
    
    internal static let TICKS_BETWEEN_REFERENCEZERO_AND_DATETIMEZERO_IN_MILLISECONDS: Int = 63113904000000
    internal static let TICKS_BETWEEN_REFERENCEZERO_AND_EPOCH_IN_SECONDS: Double = 978307200
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
            .WeekOfYear,
            .TimeZone]
    }
    
    private func addComponents(components: NSDateComponents) -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingComponents(components, toDate: _date, options: [])
    }
    
    /// Retun timeZone sensitive components
    private var components: NSDateComponents {
        return NSCalendar.currentCalendar().components(Date.componentFlags(), fromDate: _date)
    }
    
    /// Return the NSDateComponents
    private var componentsWithTimeZone: NSDateComponents {
        let timeZone = Date.dateTimeKindToNSTimeZone(_kind)
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = timeZone
        let component = NSCalendar.currentCalendar().components(Date.componentFlags(), fromDate: _date)
        component.timeZone = timeZone
        return component
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
    private static func localThreadDateFormatter() -> NSDateFormatter
    {
        return Date.cachedObjectInCurrentThread("com.library.swiftdate.dateformatter") {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return dateFormatter
        }
    }
    
    private static func dateTimeKindToNSTimeZone(kind: DateTimeKind) -> NSTimeZone
    {
        if kind == .Utc
        {
            return NSTimeZone(abbreviation: "UTC")!
        }
        return NSTimeZone.localTimeZone()
    }
}

internal extension NSDateComponents {
    
    internal func nSDateFromComponents(year year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil, nanosecond: Int? = nil, timeZone: NSTimeZone? = nil) -> NSDate!
    {
        if year != nil { self.year = year! }
        if month != nil { self.month = month! }
        if day != nil { self.day = day! }
        if hour != nil { self.hour = hour! }
        if minute != nil { self.minute = minute! }
        if second != nil { self.second = second! }
        if nanosecond != nil { self.nanosecond = nanosecond! }
        self.timeZone = (timeZone != nil ? timeZone! : NSTimeZone.defaultTimeZone())
        
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