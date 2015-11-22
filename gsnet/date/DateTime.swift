//
//  DateTime.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import Foundation

public struct DateTime: Equatable, Comparable {
    var _date: NSDate?

    private var _kind: DateTimeKind

    private static let FILETIME_ZERO: Int = 50491123200000

    private static let MACTIME_ZERO: Int = 60052751925000

    private static let WINTIME_ZERO: Int = 59926435125000

    private static let DATETIMETICK_TO_NSDATETICK: Int = 63113903925000
    
    private static let DATETIMETICK_TO_UNIX_EPOCH: Int = 621355968000000000
    
    private static let DATETIMETICK_TO_NSDATE_TICK: Int = 631139040000000000
    
    private static let SECONDS_WITH_TICKLEADINGZEROS: Int = 10000
    
    private static let TICKS_PER_MILISECOND : Int = 10000;
    private static let TICKS_PER_SECOND: Int = TICKS_PER_MILISECOND * 1000;
    private static let TICKS_PER_MINUTE: Int = TICKS_PER_SECOND * 60
    private static let TICKS_PER_HOUR: Int = TICKS_PER_MINUTE * 60
    private static let TICKS_PER_DAY: Int = TICKS_PER_HOUR * 24
  
    public var IsDaylightSavingTime : Bool {
        get {
            let timeZone = NSTimeZone.defaultTimeZone()
            return timeZone.isDaylightSavingTimeForDate(_date!)
        }
    }
    
    public var IsLeapYear : Bool {
        get {
            let year = self.Year
            return (( year % 100 != 0)) && (year%4 == 0) || year % 400 == 0
        }
    }
    
    internal var DaylightSavingTime : Int {
        get {
            if (self.IsDaylightSavingTime) {
                return Int(TimeSpan.TicksPerHour)
            }
            return 0
        }
    }
    
    internal var UTCDaylightSavingFactor : Double {
        get {
            if (self.Kind == .Utc && self.IsDaylightSavingTime) {
                return TimeSpan.TicksPerHour
            }
            return 0
        }
    }
    
    internal var _nsUnitComp : NSCalendarUnit {
        get {
            return [.Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond, .TimeZone, .Weekday, .WeekOfYear, .WeekdayOrdinal, .Quarter]
        }
    }
    
    internal static var Calendar : NSCalendar {
        get {
            return NSCalendar.currentCalendar()
        }
    }
    
    internal var components : NSDateComponents {
        get {
            return DateTime.Calendar.components(self._nsUnitComp, fromDate: _date!)
        }
    }
    
    public var Year: Int {
        get {
            return components.year
        }
    }
    
    var Month: Int {
        get {
            return components.month
        }
    }
    
    var Day: Int {
        get {
            return components.day
        }
    }
    
    var Hour: Int {
        get {
            return components.hour
        }
    }
    
    var Minute: Int {
        get {
            return components.minute
        }
    }
    
    var Second: Int {
        get {
            return components.second
        }
    }
    
    var Milisecond: Int {
        get {
            return components.nanosecond/1000000
        }
    }
    
    internal var nanosecond: Int {
        get {
            return components.nanosecond
        }
    }
    
    var DayOfWeek: DayOfWeeks {
        get {
            return DayOfWeeks(rawValue: components.weekday)!
        }
    }
    
    var DayOfYear: Int? {
        get {
            return DateTime.Calendar.ordinalityOfUnit(.Day, inUnit: .Year, forDate: _date!)
        }
    }
    
    static var MinValue : DateTime {
        get{
            let minDate = DateTime(year: 0,month: 0, day: 0)
            return minDate
        }
    }
    
    static var MaxValue : DateTime {
        get{
            let maxDate = DateTime(year: 10000, month: 13, day: 33, hour: 24, minute: 60, second: 60)
            return maxDate
        }
    }
    /**
    Returns the date part of the DateTime object [13 Jun 2015 12:09]
    
    */
    public var Date : DateTime {
        get {
            return DateTime(year: components.year, month: self.Month, day: self.Day)
        }
    }
    
    static var Now : DateTime {
        get {
            var dateTime = DateTime(nsdate: NSDate())
            dateTime.Kind = DateTimeKind.Local
            return dateTime
        }
    }
    
    static var UTCNow : DateTime {
        get {
            let dateTime = DateTime(nsdate: NSDate())
            return dateTime.ToUTC()
        }
    }
    
    var AsNSDate : NSDate? {
        get {
            return _date
        }
    }
    /**
    Returns NSDate clone object
    
    :returns: new NSDate
    */
    var AsNSDateClone : NSDate {
        get {
            return self._date?.copy() as! NSDate
        }
    }
    
    var Kind : DateTimeKind {
        get {
            return _kind
        }
        set(value) {
            _kind = value
        }
    }
    
    var TicksInEpoch: Double {
        get {
            return _date!.timeIntervalSince1970 + UTCDaylightSavingFactor / 1000
        }
    }
    
    public var Ticks: Int {
        get {
            if (self.Kind == .Utc){
                return DateTime.DateToTicksForUtc(components.year, month: components.month, day: components.day) + DateTime.TimeToTicksForUtc(components.hour, minute: components.minute, second: components.second) + components.nanosecond/1000000 * DateTime.TICKS_PER_MILISECOND
            } else {
            
            }
            return Int(_date!.timeIntervalSinceReferenceDate) * DateTime.TICKS_PER_SECOND + DateTime.DATETIMETICK_TO_NSDATE_TICK
            //return Int(Double(DateTime.DATETIMETICK_TO_NSDATETICK) + _date!.timeIntervalSinceReferenceDate * 1000 + UTCDaylightSavingFactor) * DateTime.SECONDS_WITH_TICKLEADINGZEROS
        }
    }
    
//    var TicksInFileTime: Int {
//        get {
//            let utcDateTime = self.ToUTC()
//            return (utcDateTime.Ticks - DateTime.FILETIME_ZERO) * 10000
//        }
//    }
//    
//    var TicksInMacTime: Int {
//        get {
//            let totalticks = (self.Ticks - DateTime.MACTIME_ZERO)
//            let ts = TimeSpan(ticks: totalticks)
//            return Int(ts.TotalSeconds)
//        }
//    }
//    
//    var TicksInWinTime: Double {
//        get {
//            let totalticks = (self.Ticks - DateTime.WINTIME_ZERO)
//            let ts = TimeSpan(ticks: totalticks)
//            return ts.TotalDays
//        }
//    }
    
    var TimeOfDay : TimeSpan {
        get {
            return TimeSpan(hours: self.Hour, minutes: self.Minute, seconds: self.Second)
        }
    }
    
    static var Today : DateTime {
        get {
            let today = DateTime.Now
            return DateTime(year: today.Year, month: today.Month, day: today.Day)
        }
    }
    
    
    /**
    Returns a new clone DateTime mutated with TimeSpan
    
    :param: timeSpan: TimeSpan
    
    :returns: new DateTime
    */
    func Add(timeSpan timeSpan: TimeSpan) -> DateTime{
        let date = self.Clone()
        date.AddTicks(ticks: timeSpan.Ticks)
        return date
    }
    /**
    Returns a new clone DateTime mutated with ticks
    
    :param: ticks: Int
    
    :returns: new DateTime
    */
    func AddTicks(ticks ticks: Int) -> DateTime {
        let date = self.Clone()
        date._date!.dateByAddingTimeInterval(Double(ticks/1000))
        return date
    }
    
    /**
    Mutates the DateTime object with years [13 Jun 2015 12:29]
    
    :param: years: Int
    
    :returns: Void
    */
    mutating func AddMutatingYears(years years : Int) -> Void {
        let component = NSDateComponents()
        component.year = years
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: [])
    }
    
    /**
    Returns a new clone DateTime mutated with years [13 Jun 2015 13:48]
    
    :param: years: Int
    
    :returns: new DateTime
    */
    func AddYears(years years : Int) -> DateTime {
        var date = self.Clone()
        date.AddMutatingYears(years: years)
        return date
    }
    
    /**
    Mutates the DateTime object with days
    
    :param: days: Int
    
    :returns: Void
    */
    mutating func AddMutatingDays(days days: Int) {
        let component = NSDateComponents()
        component.day = days
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: []) //.dateByAddingComponents(component, toDate: _date!, options: nil)
    }
    /**
    Returns a new clone DateTime mutated with days
    
    :param: days: Int
    
    :returns: new DateTime
    */
    func AddDays(days days: Int) -> DateTime{
        var date = self.Clone()
        date.AddMutatingDays(days: days)
        return date
    }
    /**
    Mutates the DateTime object with hours
    
    :param: hours: Int
    
    :returns: Void
    */
    mutating func AddMutatingHours(hours hours: Int) {
        let component = NSDateComponents()
        component.hour = hours
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: [])
    }
    
    /**
    Returns a new clone DateTime mutated with hours
    
    :param: hours: Int
    
    :returns: new DateTime
    */
    func AddHours(hours hours: Int) -> DateTime {
        var date = self.Clone()
        date.AddMutatingHours(hours: hours)
        return date
    }
    /**
    Mutates the DateTime object with minutes
    
    :param: minutes: Int
    
    :returns: Void
    */
    mutating func AddMutatingMinutes(minutes minutes: Int) {
        let component = NSDateComponents()
        component.minute = minutes
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: [])
    }
    
    /**
    Returns a new clone DateTime mutated with minutes
    
    :param: minutes: Int
    
    :returns: new DateTime
    */
    func AddMinutes(minutes minutes : Int) -> DateTime {
        var date = self.Clone()
        date.AddMutatingMinutes(minutes: minutes)
        return date
    }
    
    /**
    Mutates the DateTime object with seconds
    
    :param: seconds: Int
    
    :returns: Void
    */
    mutating func AddMutatingSeconds(seconds seconds: Int) {
        let component = NSDateComponents()
        component.second = seconds
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: [])
    }
    
    /**
    Returns a new clone DateTime mutated with seconds
    
    :param: seconds: Int
    
    :returns: new DateTime
    */
    func AddSeconds(seconds seconds : Int) -> DateTime {
        var date = self.Clone()
        date.AddMutatingSeconds(seconds: seconds)
        return date
    }
    
    /**
    Mutates the DateTime object with miliseconds
    
    :param: miliseconds: Int
    
    :returns: new DateTime
    */
    mutating func AddMutatingMiliseconds(miliseconds miliseconds: Int) {
        self.AddMutatingNanoseconds(nanoseconds: miliseconds * 1000000)
    }
    /**
    Returns a new clone DateTime mutated with miliseconds
    
    :param: milisecond: Int
    
    :returns: new DateTime
    */
    func AddMiliseconds(miliseconds miliseconds: Int) -> DateTime {
        var date = self.Clone()
        date.AddMutatingMiliseconds(miliseconds: miliseconds)
        return date
    }
    
    /**
    Mutates the DateTime object with nanoseconds
    
    :param: nanoseconds: Int
    
    :returns: Void
    */
    mutating func AddMutatingNanoseconds(nanoseconds nanoseconds: Int) {
        let component = NSDateComponents()
        component.nanosecond = nanoseconds
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: [])
    }
    
    /**
    Returns a new clone DateTime mutated with nanoseconds
    
    :param: nanoseconds: Int
    
    :returns: new DateTime
    */
    
    func AddNanoseconds(nanoseconds nanoseconds: Int) -> DateTime {
        var date = self.Clone()
        date.AddMutatingNanoseconds(nanoseconds: nanoseconds)
        return date
    }
    
    /**
    Returns a new clone DateTime in Local
    
    :returns: new DateTime
    */
    func ToLocal() -> DateTime {
        if (Kind != .Local) {
            let timeZone = NSTimeZone.defaultTimeZone()
            let secondsFromGMT = !timeZone.isDaylightSavingTimeForDate(_date!) ? timeZone.secondsFromGMT - 3600 : timeZone.secondsFromGMT
            let seconds: NSTimeInterval = Double(secondsFromGMT)
            _date!
            let date = NSDate(timeInterval: seconds, sinceDate: _date!)
            return DateTime(nsdate: date, fromDateTimeKind: .Local)
        } else {
            return self.Clone()
        }
    }
    
    
    /**
    Returns a new clone DateTime in UTC
    
    :returns: new DateTime
    */
    func ToUTC() -> DateTime {
        if (Kind == .Local){
            let timeZone = NSTimeZone.defaultTimeZone()
            timeZone.secondsFromGMT
            let secondsFromGMT = !timeZone.isDaylightSavingTimeForDate(_date!) ? timeZone.secondsFromGMT - 3600 : timeZone.secondsFromGMT
            let seconds: NSTimeInterval = Double(secondsFromGMT)
            let date = NSDate(timeInterval: -seconds, sinceDate: _date!)
            return DateTime(nsdate: date, fromDateTimeKind: .Utc)
        } else {
            return self.Clone()
        }
    }
    
    /**
    Converts the specified Windows file time to an equivalent local time [13 Jun 2015 14:01]
    
    :param: fileTime: Int
    
    :returns: new local DateTime
    */
    static func FromFileTime(fileTime fileTime : Int) -> DateTime {
        return (DateTime.FromFileTimeUTC(fileTime: fileTime)).ToLocal()
    }
    
    
    /**
    Converts the specified Windows filetime to an equivalent local time [15 Jun 2015 19:48]
    
    :param: filetime: Int
    
    :returns: new UTC DateTime
    */
    
    static func FromFileTimeUTC(fileTime fileTime : Int) -> DateTime {
        return DateTime(ticks: (DateTime.FILETIME_ZERO + fileTime/10000), fromDateTimeKind: .Utc)
    }
    
    /**
    Returns the number of the days in the given month
    
    :param: year/month: Int
    
    :returns: Int
    */
    static func DaysInMonth(year year : Int, month : Int) -> Int {
        let component = NSDateComponents()
        component.year = year
        component.month = month
        let calendar = DateTime.Calendar
        let nsdate = calendar.dateFromComponents(component)
        let days = calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: nsdate!)
        //.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: nsdate!)
        return days.length
    }
    
    
    /**
    Converts string representation to DateTime object [15 Jun 2015 20:14]
    
    :param: s: String
    
    :returns: new DateTime
    */
    static func Parse(string string: String, format : DateTimeFormat = DateTimeFormat.FULL) -> DateTime {
        let df = NSDateFormatter()
        df.dateFormat = format.rawValue
        return DateTime(nsdate: df.dateFromString(string)!, fromDateTimeKind: .Utc)
    }
    
    func ToString(format: DateTimeFormat = .FULL) -> String {
        let df = NSDateFormatter()
        df.dateFormat = format.rawValue
        return df.stringFromDate(self._date!)
    }
    
    init(ticks: Int, fromDateTimeKind: DateTimeKind = .Local){
        let ticksToEpoch: Int = ticks - DateTime.DATETIMETICK_TO_NSDATE_TICK
        let ticksToSecond: NSTimeInterval = Double(ticksToEpoch / DateTime.TICKS_PER_SECOND)
        _date = NSDate(timeIntervalSinceReferenceDate: ticksToSecond)
        _kind = fromDateTimeKind
    }
    
    init(ticksInEpoch: Double, fromDateTimeKind: DateTimeKind = .Local){
        _date = NSDate(timeIntervalSince1970: ticksInEpoch)
        _kind = fromDateTimeKind
        if (fromDateTimeKind == .Utc && self.IsDaylightSavingTime){
            self.AddMutatingHours(hours: -1)
        }
    }
    
    init(ticksInMacTime: Int, fromDateTimeKind: DateTimeKind = .Local){
        let totalticks = ticksInMacTime*1000 + DateTime.MACTIME_ZERO
        self.init(ticks: totalticks, fromDateTimeKind: fromDateTimeKind)
    }
    
    init(year: Int, month: Int, day: Int, dateTimeKind: DateTimeKind = .Local){
        self.init(year: year, month: month, day: day, hour: 0, minute: 0, second: 0, milisecond: 0, dateTimeKind: dateTimeKind)
    }
    
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, dateTimeKind: DateTimeKind = .Local) {
        self.init(year: year, month: month, day: day, hour: hour, minute: minute, second: second, milisecond: 0, dateTimeKind: dateTimeKind)
    }
    
    init(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, milisecond: Int, dateTimeKind: DateTimeKind = .Local) {
        let component = NSDateComponents()
        let validatedYear = DateTime.moveToRange(variable: year, min: 1, max: 9999)
        component.year = validatedYear
        let validatedMonth = DateTime.moveToRange(variable: month, min: 1, max: 12)
        component.month = validatedMonth
        let daysInMonth = DateTime.DaysInMonth(year: validatedYear, month: validatedMonth)
        component.day = DateTime.moveToRange(variable: day, min: 1, max: daysInMonth)
        component.hour = DateTime.moveToRange(variable: hour, min: 0, max: 23)
        component.minute = DateTime.moveToRange(variable: minute, min: 0, max: 59)
        component.second = DateTime.moveToRange(variable: second, min: 0, max: 59)
        component.nanosecond = DateTime.moveToRange(variable: milisecond, min: 0, max: 999)*1000000
        self.init(components: component, dateTimeKind)
    }
    
    init(nsdate: NSDate, fromDateTimeKind: DateTimeKind = .Local) {
        _date = nsdate
        _kind = fromDateTimeKind
    }
    
    init(components: NSDateComponents, _ dateTimeKind: DateTimeKind = .Local){
        _date = DateTime.Calendar.dateFromComponents(components)
        _kind = dateTimeKind
    }
    
    private static func DateToTicksForUtc(year: Int, month: Int, day: Int) -> Int
    {
        let validatedYear = DateTime.moveToRange(variable: year, min: 1, max: 9999)
        let validatedMonth = DateTime.moveToRange(variable: month, min: 1, max: 12)
        let validatedDays = DateTime.moveToRange(variable: day, min: 1, max: DateTime.DaysInMonth(year: validatedYear, month: validatedMonth))
        let years: Int = validatedYear - 1;
        let totalDays: Int = years * 365 + years / 4 - years / 100 + years / 400 + validatedDays
        return totalDays * TICKS_PER_DAY;
    }
    
    private static func TimeToTicksForUtc(hour: Int, minute: Int, second: Int) -> Int
    {
        let validatedHour = DateTime.moveToRange(variable: hour, min: 0, max: 23)
        let validatedMinute = DateTime.moveToRange(variable: minute, min: 0, max: 59)
        let validatedSecond = DateTime.moveToRange(variable: second, min: 0, max: 59)
        let totalSeconds: Int = validatedHour * 3600 + validatedMinute * 60 + validatedSecond
        return totalSeconds * DateTime.TICKS_PER_SECOND
    }
    
    /**
    Validates the input fields at object creation
    
    */
    internal static func moveToRange<T where T:Equatable, T: Comparable>(variable variable: T, min: T, max: T) -> T {
        let floor = (variable < min) ? min : variable
        let ceiling = (floor > max) ? max : floor
        return ceiling
    }
    /**
    Returns a clone of DateTime struct
    
    :returns: new DateTime
    */
    func Clone() -> DateTime {
        return DateTime(nsdate: self.AsNSDateClone, fromDateTimeKind: Kind)
    }
    
    static func Compare(dateTime1 dateTime1 : DateTime, dateTime2 : DateTime) -> Int {
        switch (dateTime1, dateTime2) {
        case _ where dateTime1.Ticks < dateTime2.Ticks:
            return -1
        case _ where dateTime1.Ticks == dateTime2.Ticks:
            return 0
        default:
            return 1
        }
    }
    
    func CompareTo(dateTime dateTime : DateTime) -> Int {
        return DateTime.Compare(dateTime1: self, dateTime2: dateTime)
    }
    
    /**
    Retruns a value indicating if the objects are equal [11 Jun 2015 22:52]
    
    :param: dateTime: DateTIme
    
    :returns: Bool
    */
    func Equals(dateTime dateTime : DateTime) -> Bool {
        let left = Kind
        let right = dateTime.Kind
        if self.Ticks == dateTime.Ticks && left == right {
            return true
        } else {
            return false
        }
    }
    
    static func Equals(dateTime1 dateTime1 : DateTime, dateTime2 : DateTime) -> Bool {
        return dateTime1.Equals(dateTime: dateTime2)
    }
}

public func == (l: DateTime, r: DateTime) -> Bool {
    return l.Kind == r.Kind && l.Ticks == r.Ticks
}

public func < (l: DateTime, r: DateTime) -> Bool {
    return l.Kind == r.Kind && l.Ticks < r.Ticks
}

public func <= (l: DateTime, r: DateTime) -> Bool {
    return l.Kind == r.Kind && l.Ticks <= r.Ticks
}

public func > (l: DateTime, r: DateTime) -> Bool {
    return l.Kind == r.Kind && l.Ticks > r.Ticks
}

public func >= (l: DateTime, r: DateTime) -> Bool {
    return l.Kind == r.Kind && l.Ticks >= r.Ticks
}
