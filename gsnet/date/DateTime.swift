//
//  DateTime.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public struct DateTime : Equatable, Comparable {
    
    private static let TicksPerMillisecond : long = 10000;
    private static let TicksPerSecond: long = TicksPerMillisecond * 1000;
    private static let TicksPerMinute: long = TicksPerSecond * 60
    private static let TicksPerHour: long = TicksPerMinute * 60
    private static let TicksPerDay: long = TicksPerHour * 24
    
    // Number of milliseconds per time unit
    private static let MillisPerSecond: int = 1000
    private static let MillisPerMinute: int = MillisPerSecond * 60
    private static let MillisPerHour: int = MillisPerMinute * 60
    private static let MillisPerDay: int = MillisPerHour * 24
    
    // Number of days in a non-leap year
    private static let DaysPerYear: int = 365
    // Number of days in 4 years
    private static let DaysPer4Years: int = DaysPerYear * 4 + 1       // 1461
    // Number of days in 100 years
    private static let DaysPer100Years: int = DaysPer4Years * 25 - 1  // 36524
    // Number of days in 400 years
    private static let DaysPer400Years: int = DaysPer100Years * 4 + 1 // 146097
    
    // Number of days from 1/1/0001 to 12/31/1600
    private static let DaysTo1601: int = DaysPer400Years * 4          // 584388
    // Number of days from 1/1/0001 to 12/30/1899
    private static let DaysTo1899: int = DaysPer400Years * 4 + DaysPer100Years * 3 - 367
    // Number of days from 1/1/0001 to 12/31/1969
    internal static let DaysTo1970: int = DaysPer400Years * 4 + DaysPer100Years * 3 + DaysPer4Years * 17 + DaysPerYear // 719,162
    // Number of days from 1/1/0001 to 12/31/9999
    private static let DaysTo10000: int = DaysPer400Years * 25 - 366  // 3652059
    
    internal static let MinTicks: long = 0
    internal static let MaxTicks: long = long(DaysTo10000) * long(TicksPerDay) - 1
    private static let MaxMillis: long = long(DaysTo10000) * long(MillisPerDay)
    
    private static let FileTimeOffset: long = long(DaysTo1601) * TicksPerDay
    private static let DoubleDateOffset: long = long(DaysTo1899) * TicksPerDay
    // The minimum OA date is 0100/01/01 (Note it's year 100).
    // The maximum OA date is 9999/12/31
    private static let OADateMinAsTicks: long = (long(DaysPer100Years) - long(DaysPerYear)) * TicksPerDay
    // All OA dates must be greater than (not >=) OADateMinAsDouble
    private static let OADateMinAsDouble: double = -657435.0
    // All OA dates must be less than (not <=) OADateMaxAsDouble
    private static let OADateMaxAsDouble: double = 2958466.0
    
    private static let DatePartYear: int = 0
    private static let DatePartDayOfYear: int = 1
    private static let DatePartMonth: int = 2
    private static let DatePartDay: int = 3
    
    private static let DaysToMonth365: [Int] = [
    0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]
    private static let DaysToMonth366: [Int] = [
    0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366]
    
    public static let MinValue: DateTime = DateTime(ticks: MinTicks, dateTimeKind: DateTimeKind.Unspecified)
    public static let MaxValue: DateTime = DateTime(ticks: MaxTicks, dateTimeKind: DateTimeKind.Unspecified)
    
    private static let TicksMask: ulong = 0x3FFFFFFFFFFFFFFF
    private static let FlagsMask: ulong = 0xC000000000000000
    private static let LocalMask: ulong = 0x8000000000000000
    private static let TicksCeiling: long = 0x4000000000000000
    private static let KindUnspecified: ulong = 0x0000000000000000
    private static let KindUtc: ulong = 0x4000000000000000
    private static let KindLocal: ulong = 0x8000000000000000
    private static let KindLocalAmbiguousDst: ulong = 0xC000000000000000
    private static let KindShift: int = 62
    
    private static let TicksField: String = "ticks"
    private static let DateDataField: String = "dateData"
    
    // The data is stored as an unsigned 64-bit integeter
    //   Bits 01-62: The value of 100-nanosecond ticks where 0 represents 1/1/0001 12:00am, up until the value
    //               12/31/9999 23:59:59.9999999
    //   Bits 63-64: A four-state value that describes the DateTimeKind value of the date time, with a 2nd
    //               value for the rare case where the date time is local, but is in an overlapped daylight
    //               savings time hour and it is in daylight savings time. This allows distinction of these
    //               otherwise ambiguous local times and prevents data loss when round tripping from Local to
    //               UTC time.
    var _dateData: ulong
    var _dateTimeKind: DateTimeKind
    
    // Constructs a DateTime from a tick count. The ticks
    // argument specifies the date as the number of 100-nanosecond intervals
    // that have elapsed since 1/1/0001 12:00am.
    public init(ticks: long)
    {
        self.init(ticks: ticks, dateTimeKind: DateTimeKind.Unspecified)
    }
    
    private init(dateData: ulong)
    {
        self.init(dateData: dateData, dateTimeKind: DateTimeKind.Unspecified)
    }
    
    private init(dateData: ulong, dateTimeKind: DateTimeKind)
    {
        _dateData = dateData
        _dateTimeKind = dateTimeKind
    }
    
    public init(ticks: long, dateTimeKind: DateTimeKind)
    {
        let ticks = ulong(DateTime.range(variable: ticks, min: DateTime.MinTicks, max: DateTime.MaxTicks))
        _dateData = (ulong(ticks) | ulong(dateTimeKind.rawValue) << ulong(DateTime.KindShift))
        _dateTimeKind = dateTimeKind
    }
   
    internal init(ticks: long, dateTimeKind: DateTimeKind, isAmbiguousDst: Bool)
    {
        let tick = ulong(DateTime.range(variable: ticks, min: DateTime.MinTicks, max: DateTime.MaxTicks))
        _dateData = tick | (isAmbiguousDst ? DateTime.KindLocalAmbiguousDst : DateTime.KindLocal)
        _dateTimeKind = dateTimeKind
    }

    public init(year: int, month: int, day: int)
    {
        self.init(year: year, month: month, day: day, dateTimeKind: DateTimeKind.Unspecified)
    }
    
    // TODO: Create constructor with calendar object
    /*
    public init(year: int, month: int, day: int, calendar: Calendar){
        _dateData = 0
        _dateTimeKind = .Unspecified
    }
    */
    
    public init(year: int, month: int, day: int, dateTimeKind: DateTimeKind)
    {
        _dateData = DateTime.DateToTicks(year, month: month, day: day)
        _dateTimeKind = dateTimeKind
    }
    
    public init(year: int, month: int, day: int, hour: int, minute: int, second: int, dateTimeKind: DateTimeKind)
    {
        let ticks = DateTime.DateToTicks(year, month: month, day: day) + DateTime.TimeToTicks(hour, minute: minute, second: second)
        _dateData = (ulong(ticks) | ulong(dateTimeKind.rawValue) << ulong(DateTime.KindShift))
        _dateTimeKind = dateTimeKind
    }
    
    //TODO: Create constructor with calendar object
    /*
    // Constructs a DateTime from a given year, month, day, hour,
    // minute, and second for the specified calendar.
    //
    public DateTime(int year, int month, int day, int hour, int minute, int second, Calendar calendar) {
    if (calendar == null)
    throw new ArgumentNullException("calendar");
    Contract.EndContractBlock();
    this.dateData = (UInt64)calendar.ToDateTime(year, month, day, hour, minute, second, 0).Ticks;
    }
    */
    
    // Constructs a DateTime from a given year, month, day, hour,
    // minute, and second.
    //
    public init(year: int, month: int, day: int, hour: int, minute: int, second: int, millisecond: int)
    {
        self.init(year: year, month: month, day: day, hour: hour, minute: minute, second: second, millisecond: millisecond, dateTimeKind: DateTimeKind.Unspecified)
    }
    
    public init(year: int, month: int, day: int, hour: int, minute: int, second: int, millisecond: int, dateTimeKind: DateTimeKind)
    {
        let validatedMillisecond = DateTime.range(variable: millisecond, min: 0, max: DateTime.MillisPerSecond)
        let ticks = DateTime.DateToTicks(year, month: month, day: day) + DateTime.TimeToTicks(hour, minute: minute, second: second) + ulong(validatedMillisecond) * ulong(DateTime.TicksPerMillisecond)
        let validatedTicks = DateTime.range(variable: ticks, min: ulong(DateTime.MinTicks), max: ulong(DateTime.MaxTicks))
        _dateData = (ulong(validatedTicks) | ulong(dateTimeKind.rawValue) << ulong(DateTime.KindShift))
        _dateTimeKind = dateTimeKind
    }
    
    //TODO: Create constructor with calendar object
    /*
    // Constructs a DateTime from a given year, month, day, hour,
    // minute, and second for the specified calendar.
    //
    public DateTime(int year, int month, int day, int hour, int minute, int second, int millisecond, Calendar calendar) {
    */
    
    // Returns the tick count corresponding to the given year, month, and day.
    // Will check the if the parameters are valid.
    private static func DateToTicks(year: int, month: int, day: int) -> ulong
    {
        let validatedYear = DateTime.range(variable: year, min: 1, max: 9999)
        let validatedMonth = DateTime.range(variable: month, min: 1, max: 12)
        let validatedDays = DateTime.range(variable: day, min: 1, max: DateTime.DaysInMonth(year: validatedYear, month: validatedMonth))
        let days = DateTime.IsLeapYear(year: validatedYear) ? DaysToMonth366 : DaysToMonth365
        
        let y: int = validatedYear - 1;
        let n: int = y * 365 + y / 4 - y / 100 + y / 400 + days[Int(month) - 1] + validatedDays - 1;
        return ulong(n) * ulong(TicksPerDay);
    }

    
    // Return the tick count corresponding to the given hour, minute, second.
    // Will check the if the parameters are valid.
    private static func TimeToTicks(hour: int, minute: int, second: int) -> ulong
    {
        //TimeSpan.TimeToTicks is a family access function which does no error checking, so
        //we need to put some error checking out here.
        let validatedHour = DateTime.range(variable: hour, min: 0, max: 23)
        let validatedMinute = DateTime.range(variable: minute, min: 0, max: 59)
        let validatedSecond = DateTime.range(variable: second, min: 0, max: 59)
        let totalSeconds: long = long(validatedHour) * long(3600) + long(validatedMinute) * 60 + long(validatedSecond)
        return ulong(totalSeconds) * ulong(TicksPerSecond)

    }
    
    private static func range<T where T:Equatable, T:Comparable> (variable variable: T, min: T, max: T) -> T
    {
        let floor = (variable < min ) ? min : variable
        let ceiling = (floor > max) ? max : floor
        return ceiling
    }
    
    // Checks whether a given year is a leap year. This method returns true if
    // year is a leap year, or false if not.
    //
    public static func IsLeapYear(year year: int) -> Bool
    {
        let validatedYear = DateTime.range(variable: year, min: 1, max: 9999)
        return validatedYear % 4 == 0 && (validatedYear % 100 != 0 || validatedYear % 400 == 0)
    }
    
    public static func DaysInMonth(year year: int, month: int) -> int
    {
        let validatedYear = DateTime.range(variable: year, min: 1, max: 9999)
        let validatedMonth = DateTime.range(variable: month, min: 1, max: 12)

    // IsLeapYear checks the year argument
        let days: [Int]  = IsLeapYear(year: validatedYear) ? DaysToMonth366 : DaysToMonth365
        return int(days[Int(validatedMonth)] - days[Int(validatedMonth) - 1]);
    }
    
    internal var InternalTicks: long {
        get {
            return long(_dateData & DateTime.TicksMask)
        }
    }
    
    private var InternalKind: ulong {
        get {
            return (_dateData & DateTime.FlagsMask);
        }
    }
    
    private func Add(value: double, scale: int) -> DateTime
    {
        let millis: long = long(value * double(scale) + (value >= 0 ? 0.5 : -0.5))
        let validatedMillis = DateTime.range(variable: millis, min: 0, max: DateTime.MaxMillis)
        return AddTicks(validatedMillis * DateTime.TicksPerMillisecond)
    }
    
    public func Add(value value: TimeSpan) -> DateTime
    {
        return AddTicks(long(value.Ticks))
    }
    
    public func AddTicks(value: long) -> DateTime
    {
        let ticks = DateTime.range(variable: InternalTicks, min: DateTime.MinTicks, max: DateTime.MaxTicks)
        return DateTime(dateData: ulong(ticks + value) | InternalKind);
    }
    
    public func AddDays(value: double) -> DateTime
    {
        return Add(value, scale: DateTime.MillisPerDay)
    }
    
    public func AddHours(value: double) -> DateTime
    {
        return Add(value, scale: DateTime.MillisPerHour)
    }
    
    public func AddMilliseconds(value: double) -> DateTime
    {
        return Add(value, scale: 1)
    }
    
    public func AddMinutes(value: double) -> DateTime
    {
        return Add(value, scale: DateTime.MillisPerMinute)
    }
    
    public func AddMonths(months: int) -> DateTime
    {
        let validatedMonth = DateTime.range(variable: months, min: -120000, max: 120000)

        var y: int = GetDatePart(DateTime.DatePartYear);
        var m: int = GetDatePart(DateTime.DatePartMonth);
        var d: int = GetDatePart(DateTime.DatePartDay);
        let i: int = m - 1 + validatedMonth;
        if (i >= 0) {
            m = i % 12 + 1;
            y = y + i / 12;
        }
        else {
            m = 12 + (i + 1) % 12;
            y = y + (i - 11) / 12;
        }
        let validatedY = DateTime.range(variable: y, min: 1, max: 9999)
        let days: int = DateTime.DaysInMonth(year: validatedY, month: m);
        if (d > days) {
            d = days
        }
        let ticks: ulong = (ulong(
                                DateTime.DateToTicks(validatedY, month: m, day: d)
                                    + ulong(InternalTicks)
                                    % ulong(DateTime.TicksPerDay)
                                ) | InternalKind)
        return DateTime(dateData: ticks)
    }
    
    public func AddSeconds(value: double) -> DateTime {
        return Add(value, scale: DateTime.MillisPerSecond)
    }
    
    public func AddYears(value: int) -> DateTime {
        let validatedValue = DateTime.range(variable: value, min: -10000, max: 10000)
        return AddMonths(validatedValue * 12)
    }
    
    // Creates a DateTime from a Windows filetime. A Windows filetime is
    // a long representing the date and time as the number of
    // 100-nanosecond intervals that have elapsed since 1/1/1601 12:00am.
    //
    public static func FromFileTime(fileTime: long) -> DateTime
    {
        return FromFileTimeUtc(fileTime).ToLocalTime();
    }
    
    public func ToLocalTime() -> DateTime
    {
        return ToLocalTime(false);
    }
    
    public var Kind: DateTimeKind {
        get {
            switch (self.InternalKind){
            case DateTime.KindUnspecified:
                return DateTimeKind.Unspecified
            case DateTime.KindUtc:
                return DateTimeKind.Utc
            default:
                return DateTimeKind.Local
            }
        }
    }
    
    internal func ToLocalTime(throwOnOverflow: Bool) -> DateTime
    {
        if (Kind == DateTimeKind.Local) {
            return self;
        }
        let isDaylightSavings: Bool = false;
        let isAmbiguousLocalDst: Bool = false;
        let offset: long = TimeZoneInfo.GetUtcOffsetFromUtc(this, TimeZoneInfo.Local, out isDaylightSavings, out isAmbiguousLocalDst).Ticks;
        long tick = Ticks + offset;
        if (tick > DateTime.MaxTicks)
        {
        if (throwOnOverflow)
        throw new ArgumentException(Environment.GetResourceString("Arg_ArgumentOutOfRangeException"));
        else
        return new DateTime(DateTime.MaxTicks, DateTimeKind.Local);
        }
        if (tick < DateTime.MinTicks)
        {
        if (throwOnOverflow)
        throw new ArgumentException(Environment.GetResourceString("Arg_ArgumentOutOfRangeException"));
        else
        return new DateTime(DateTime.MinTicks, DateTimeKind.Local);
        }
        return new DateTime(tick, DateTimeKind.Local, isAmbiguousLocalDst);
    }
    
    public static func FromFileTimeUtc(fileTime: long) -> DateTime
    {
        let validatedFileTime = DateTime.range(variable: fileTime, min: 0, max: DateTime.MaxTicks - DateTime.FileTimeOffset)
    
        // This is the ticks in Universal time for this fileTime.
        let universalTicks: long = validatedFileTime + FileTimeOffset;
        return DateTime(ticks: universalTicks, dateTimeKind: DateTimeKind.Utc);
    }

    // Returns a given date part of this DateTime. This method is used
    // to compute the year, day-of-year, month, or day part.
    private func GetDatePart(part: int) -> int {
        let ticks = InternalTicks
        // n = number of days since 1/1/0001
        var daysSince0001 : int = int(ticks / DateTime.TicksPerDay)
        // y400 = number of whole 400-year periods since 1/1/0001
        let y400: int = daysSince0001 / DateTime.DaysPer400Years
        // n = day number within 400-year period
        daysSince0001 -= y400 * DateTime.DaysPer400Years
        // y100 = number of whole 100-year periods within 400-year period
        var y100: int = daysSince0001 / DateTime.DaysPer100Years
        // Last 100-year period has an extra day, so decrement result if 4
        if (y100 == 4) {
            y100 = 3
        }
        // n = day number within 100-year period
        daysSince0001 -= y100 * DateTime.DaysPer100Years
        // y4 = number of whole 4-year periods within 100-year period
        let y4: int = daysSince0001 / DateTime.DaysPer4Years
        // n = day number within 4-year period
        daysSince0001 -= y4 * DateTime.DaysPer4Years
        // y1 = number of whole years within 4-year period
        var y1: int = daysSince0001 / DateTime.DaysPerYear
        // Last year has an extra day, so decrement result if 4
        if (y1 == 4) {
           y1 = 3
        }
        // If year was requested, compute and return it
        if (part == DateTime.DatePartYear) {
            return y400 * 400 + y100 * 100 + y4 * 4 + y1 + 1;
        }
        // n = day number within year
        daysSince0001 -= y1 * DateTime.DaysPerYear;
        // If day-of-year was requested, return it
        if (part == DateTime.DatePartDayOfYear) {
            return daysSince0001 + 1;
        }
        // Leap year calculation looks different from IsLeapYear since y1, y4,
        // and y100 are relative to year 1, not year 0
        let leapYear: Bool = y1 == 3 && (y4 != 24 || y100 == 3)
        let days: [Int] = leapYear ?  DateTime.DaysToMonth366: DateTime.DaysToMonth365
        // All months have less than 32 days, so n >> 5 is a good conservative
        // estimate for the month
        var m: Int = Int(daysSince0001) >> 5 + 1
        // m = 1-based month number
        while (Int(daysSince0001) >= days[m]) {
            m++
        }
        // If month was requested, return it
        if (part == DateTime.DatePartMonth) {
            return int(m)
        }
        // Return 1-based day-of-month
        return daysSince0001 - days[m - 1] + 1;
    }
}

public func == (l: DateTime, r: DateTime) -> Bool {
    return l._dateData == r._dateData
}

public func < (l: DateTime, r: DateTime) -> Bool {
    return l._dateData < r._dateData
}

public func <= (l: DateTime, r: DateTime) -> Bool {
    return l._dateData <= r._dateData
}

public func > (l: DateTime, r: DateTime) -> Bool {
    return l._dateData > r._dateData
}

public func >= (l: DateTime, r: DateTime) -> Bool {
    return l._dateData >= r._dateData
}

/*
struct DateTime {
    var _date: NSDate?

    private var _kind: DateTimeKind

    private static let FILETIME_ZERO: Int = 50491123200000

    private static let MACTIME_ZERO: Int = 60052751925000

    private static let WINTIME_ZERO: Int = 59926435125000

    private static let MIN_TO_ABSOLUTE: Int = 63113903925000

    enum DateTimeKind : Int, CustomStringConvertible {
        case UTC, Local, Unspecified
        
        var description: String {
            get {
                switch self {
                case .UTC:
                    return "UTC"
                case .Local:
                    return "Local"
                case .Unspecified:
                    return "Unspecified"
                }
            }
        }
    }
    
    var IsDaylightSavingTime : Bool {
        get {
            let timeZone = NSTimeZone.defaultTimeZone()
            return timeZone.isDaylightSavingTimeForDate(_date!)
        }
    }
    
    var IsLeapYear : Bool {
        get {
            let year = self.Year
            return (( year % 100 != 0)) && (year%4 == 0) || year % 400 == 0
        }
    }
    
    var DaylightSavingTime : Int {
        get {
            if (self.IsDaylightSavingTime) {
                return Int(TimeSpan.TicksPerHour)
            }
            return 0
        }
    }
    
    var UTCDaylightSavingFactor : Double {
        get {
            if (self.Kind == .UTC && self.IsDaylightSavingTime) {
                return TimeSpan.TicksPerHour
            }
            return 0
        }
    }
    
    private var _nsUnitComp : NSCalendarUnit {
        get {
            return NSCalendarUnit.CalendarUnitYear|NSCalendarUnit.CalendarUnitMonth|NSCalendarUnit.CalendarUnitDay|NSCalendarUnit.CalendarUnitHour|NSCalendarUnit.CalendarUnitMinute|NSCalendarUnit.CalendarUnitSecond|NSCalendarUnit.CalendarUnitNanosecond|NSCalendarUnit.CalendarUnitTimeZone|NSCalendarUnit.CalendarUnitWeekday|NSCalendarUnit.CalendarUnitWeekOfYear|NSCalendarUnit.CalendarUnitWeekdayOrdinal|NSCalendarUnit.CalendarUnitQuarter
        }
    }
    
    static var Calendar : NSCalendar {
        get {
            return NSCalendar.currentCalendar()
        }
    }
    
    var components : NSDateComponents {
        get {
            return DateTime.Calendar.components(self._nsUnitComp, fromDate: _date!)
        }
    }
    
    var Year: Int {
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
    
    private var nanosecond: Int {
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
            return DateTime.Calendar.ordinalityOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitYear, forDate: NSDate())
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
    var Date : DateTime {
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
    
    var Ticks: Int {
        get {
            return Int(Double(DateTime.MIN_TO_ABSOLUTE) + _date!.timeIntervalSinceReferenceDate * 1000 + UTCDaylightSavingFactor)
        }
    }
    
    var TicksInFileTime: Int {
        get {
            let utcDateTime = self.ToUTC()
            return (utcDateTime.Ticks - DateTime.FILETIME_ZERO) * 10000
        }
    }
    
    var TicksInMacTime: Int {
        get {
            let totalticks = (self.Ticks - DateTime.MACTIME_ZERO)
            let ts = TimeSpan(ticks: totalticks)
            return Int(ts.TotalSeconds)
        }
    }
    
    var TicksInWinTime: Double {
        get {
            let totalticks = (self.Ticks - DateTime.WINTIME_ZERO)
            let ts = TimeSpan(ticks: totalticks)
            return ts.TotalDays
        }
    }
    
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
        date.AddTicks(ticks: timeSpan.Tick)
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
        var component = NSDateComponents()
        component.year = years
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: nil)
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
        var component = NSDateComponents()
        component.day = days
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: nil)
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
        var component = NSDateComponents()
        component.hour = hours
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: nil)
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
        var component = NSDateComponents()
        component.minute = minutes
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: nil)
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
        var component = NSDateComponents()
        component.second = seconds
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: nil)
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
        var component = NSDateComponents()
        component.nanosecond = nanoseconds
        _date = DateTime.Calendar.dateByAddingComponents(component, toDate: _date!, options: nil)
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
            return DateTime(nsdate: date, fromDateTimeKind: .UTC)
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
        return DateTime(ticks: (DateTime.FILETIME_ZERO + fileTime/10000), fromDateTimeKind: .UTC)
    }
    
    /**
    Returns the number of the days in the given month
    
    :param: year/month: Int
    
    :returns: Int
    */
    static func DaysInMonth(year year : Int, month : Int) -> Int {
        var component = NSDateComponents()
        component.year = DateTime.range(variable: year, min: 1, max: 9999)
        component.month = DateTime.range(variable: month, min: 0, max: 12)
        var calendar = DateTime.Calendar
        var nsdate = calendar.dateFromComponents(component)
        var days = calendar.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: nsdate!)
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
        return DateTime(nsdate: df.dateFromString(string)!, fromDateTimeKind: DateTimeKind.UTC)
    }
    
    func ToString(format: DateTimeFormat = .FULL) -> String {
        let df = NSDateFormatter()
        df.dateFormat = format.rawValue
        return df.stringFromDate(self._date!)
    }
    
    init(ticks: Int, fromDateTimeKind: DateTimeKind = .Local){
        let offset = (ticks - DateTime.MIN_TO_ABSOLUTE)/1000
        _date = NSDate(timeIntervalSinceReferenceDate: Double(offset))
        _kind = fromDateTimeKind
        if (fromDateTimeKind == .UTC && self.IsDaylightSavingTime){
            self.AddMutatingHours(hours: -1)
        }
    }
    
    init(ticksInEpoch: Double, fromDateTimeKind: DateTimeKind = .Local){
        _date = NSDate(timeIntervalSince1970: ticksInEpoch)
        _kind = fromDateTimeKind
        if (fromDateTimeKind == .UTC && self.IsDaylightSavingTime){
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
        let validatedYear = DateTime.range(variable: year, min: 1, max: 9999)
        component.year = validatedYear
        let validatedMonth = DateTime.range(variable: month, min: 1, max: 12)
        component.month = validatedMonth
        let daysInMonth = DateTime.DaysInMonth(year: validatedYear, month: validatedMonth)
        component.day = DateTime.range(variable: day, min: 1, max: daysInMonth)
        component.hour = DateTime.range(variable: hour, min: 0, max: 23)
        component.minute = DateTime.range(variable: minute, min: 0, max: 59)
        component.second = DateTime.range(variable: second, min: 0, max: 59)
        component.nanosecond = DateTime.range(variable: milisecond, min: 0, max: 999)*1000000
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
    
    
    /**
    Validates the input fields at object creation
    
    */
    private static func range(variable variable: Int, min: Int, max: Int) -> Int {
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
*/
