//
//  DateTimeTests.swift
//  gsnet
//
//  Created by Gabor Soulavy on 21/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import XCTest
@testable import gsnet

class Date_Tests: XCTestCase {


    override func setUp() {
        
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }

    func test_CreateDateTimeWith_Year_Month_Day() {

        let dt: DateTime = DateTime(year: 2001, month: 01, day: 01)
        XCTAssertNotNil(dt as DateTime)
    }

    func test_GetYear_Month_Day_BackFromInit() {
        let year = 2001
        let month = 02
        let day = 03
        let dt: DateTime = DateTime(year: year, month: month, day: day)
        XCTAssertEqual(dt.Year, year)
        XCTAssertEqual(dt.Month, month)
        XCTAssertEqual(dt.Day, day)
    }

    func test_GetFullSetDate() {
        let year = 1994
        let month = 3
        let day = 22
        let hour = 17
        let min = 15
        let sec = 11
        let millisecond = 555
        let dt: DateTime = DateTime(year: year, month: month, day: day, hour: hour, minute: min, second: sec, millisecond: millisecond, kind: .Local)
        XCTAssertEqual(dt.Year, year)
        XCTAssertEqual(dt.Month, month)
        XCTAssertEqual(dt.Day, day)
        XCTAssertEqual(dt.Hour, hour)
        XCTAssertEqual(dt.Minute, min)
        XCTAssertEqual(dt.Second, sec)
        XCTAssertEqual(dt.Millisecond, millisecond)
    }

    func test_GetKindFromDate() {
        let dt: DateTime = DateTime(year: 2001, month: 01, day: 01, kind: .Local)
        XCTAssertEqual(dt.Kind, DateTimeKind.Local)
        let dt2: DateTime = DateTime(year: 2001, month: 02, day: 02, kind: .Utc)
        XCTAssertEqual(dt2.Kind, DateTimeKind.Utc)
        let dt3: DateTime = DateTime(year: 2001, month: 03, day: 04)
        XCTAssertEqual(dt3.Kind, DateTimeKind.Local)
    }

    func test_AsDate() {
        let dt: DateTime = DateTime(year: 2001, month: 02, day: 03)
        XCTAssertNotNil(dt.AsDate! as NSDate)
    }

    func test_ToNSDate() {
        let dt: DateTime = DateTime(year: 1255, month: 03, day: 4)
        XCTAssertNotNil(dt.ToNSDate! as NSDate)
        let dt2: DateTime = DateTime(year: 1244, month: 02, day: 5, kind: .Utc)
        XCTAssertNotNil(dt2.ToNSDate! as NSDate)
    }

    func test_ToNSDate_Into_New_DateObject_Utc() {
        let dt1: DateTime = DateTime(year: 1266, month: 03, day: 5, kind: .Utc)
        let nsdate: NSDate = dt1.ToNSDate!
        let dt2: DateTime = DateTime(nsdate: nsdate)
        XCTAssertNotNil(dt2 as DateTime)
    }

    func test_ToNSDate_Into_New_DateObject_Non_Utc() {
        let dt1: DateTime = DateTime(year: 1266, month: 03, day: 5)
        let nsdate: NSDate = dt1.ToNSDate!
        let dt2: DateTime = DateTime(nsdate: nsdate)
        XCTAssertNotNil(dt2 as DateTime)
    }

    func test_Tick_Reference_Utc() {
        let dt1: DateTime = DateTime(year: 2011, month: 04, day: 1, hour: 0, minute: 0, second: 0, millisecond: 888, kind: .Utc)
        let dt2: DateTime = DateTime(interval: dt1.Interval, kind: .Utc)
        XCTAssertEqual(dt1.Year, dt2.Year)
        XCTAssertEqual(dt1.Month, dt2.Month)
        XCTAssertEqual(dt1.Day, dt2.Day)
        XCTAssertEqual(dt1.Hour, dt2.Hour)
        XCTAssertEqual(dt1.Minute, dt2.Minute)
        XCTAssertEqual(dt1.Second, dt2.Second)
        XCTAssertEqual(dt1.Millisecond, dt2.Millisecond)
    }

    func test_Tick_Reference_Local() {
        let dt1: DateTime = DateTime(year: 2011, month: 04, day: 4, hour: 11, minute: 22, second: 11, millisecond: 888, kind: .Local)
        let dt2: DateTime = DateTime(interval: dt1.Interval, kind: .Local)
        XCTAssertEqual(dt1.Year, dt2.Year)
        XCTAssertEqual(dt1.Month, dt2.Month)
        XCTAssertEqual(dt1.Day, dt2.Day)
        XCTAssertEqual(dt1.Hour, dt2.Hour)
        XCTAssertEqual(dt1.Minute, dt2.Minute)
        XCTAssertEqual(dt1.Second, dt2.Second)
        XCTAssertEqual(dt1.Millisecond, dt2.Millisecond)
    }

    func test_InitDtTick_Utc() {
        let dt: DateTime = DateTime(ticks: 618700000000000000, kind: .Utc)
        XCTAssertEqual(dt.Year, 1961)
        XCTAssertEqual(dt.Month, 8)
        XCTAssertEqual(dt.Day, 1)
        XCTAssertEqual(dt.Hour, 23)
        XCTAssertEqual(dt.Minute, 6)
        XCTAssertEqual(dt.Second, 40)
        XCTAssertEqual(dt.Millisecond, 0)
    }

    func test_DtTicks_Prop_Utc() {
        let dt: DateTime = DateTime(year: 1961, month: 8, day: 1, hour: 23, minute: 6, second: 40, millisecond: 0, kind: .Utc)
        XCTAssertEqual(dt.Ticks, 618700000000000000)
    }

    func test_InitLDapTick_Utc() {
        let dt: DateTime = DateTime(ldap: 113682993225550000, kind: .Utc)
        XCTAssertEqual(dt.Year, 1961)
        XCTAssertEqual(dt.Month, 4)
        XCTAssertEqual(dt.Day, 1)
        XCTAssertEqual(dt.Hour, 12)
        XCTAssertEqual(dt.Minute, 55)
        XCTAssertEqual(dt.Second, 22)
        XCTAssertEqual(dt.Millisecond, 555)
    }
    
    func test_DateProp() {
        let dt: DateTime = DateTime(year: 1991, month: 06, day: 03, hour: 12, minute: 11, second: 12, kind: .Utc)
        XCTAssertEqual(dt.Hour, 12)
        XCTAssertEqual(dt.Minute, 11)
        XCTAssertEqual(dt.Second, 12)
        
        let dt2 = dt.Date
        XCTAssertEqual(dt2.Hour, 0)
        XCTAssertEqual(dt2.Minute, 0)
        XCTAssertEqual(dt2.Second, 0)
    }

    func test_LDAPTicks_Prop_Utc() {
        let dt = DateTime(year: 1961, month: 04, day: 01, hour: 12, minute: 55, second: 22, millisecond: 555, kind: DateTimeKind.Utc);
        XCTAssertEqual(dt.LDAP, 113682993225550000)
    }
    
    func test_SetFirstDayOfWeekToMonday() {
        let dt = DateTime(year: 1961, month: 04, day: 01, kind: .Utc, weekStarts: .Monday)
        XCTAssertEqual(dt.WeekStarts, DayOfWeeks.Monday)
    }
    
    func test_FirstDayOfWeekDefaultIsSunday() {
        let dt = DateTime(year: 1961, month: 04, day: 01, kind: .Utc)
        XCTAssertEqual(dt.WeekStarts, DayOfWeeks.Sunday)
    }
    
    func test_WeekdayIs2For20151208_WeekStartsWithMonday() {
        let dt = DateTime(year: 2015, month: 12, day: 08, kind: .Utc, weekStarts: .Monday)
        XCTAssertEqual(dt.Weekday, 2)
    }
    
    func test_WeekdayIs2For20151208_WeekStartsWithTuesday() {
        let dt = DateTime(year: 2015, month: 12, day: 08, kind: .Utc, weekStarts: .Tuesday)
        XCTAssertEqual(dt.Weekday, 1)
    }
    
    func test_WeekdayIs3For20151208_WeekStartsDefault() {
        let dt = DateTime(year: 2015, month: 12, day: 08, kind: .Utc)
        XCTAssertEqual(dt.Weekday, 3)
    }
    
    func test_WeekStartProperty() {
        var dt = DateTime(year: 2015, month: 12, day: 08, kind: .Utc)
        XCTAssertEqual(dt.Weekday, 3)
        dt.WeekStarts = .Monday
        XCTAssertEqual(dt.Weekday, 2)
    }
    
    func test_DayOfWeeksReturnsTuesday() {
        let dt = DateTime(year: 2015, month: 12, day: 08, kind: .Utc, weekStarts: .Monday)
        XCTAssertEqual(dt.DayOfWeek, DayOfWeeks.Tuesday)
    }
    
    func test_DayOfWeeksReturnsMonday() {
        let dt = DateTime(year: 2015, month: 12, day: 07, kind: .Utc, weekStarts: .Sunday)
        XCTAssertEqual(dt.DayOfWeek, DayOfWeeks.Monday)
    }
    
    func test_DayOfWeeksReturnsSaturday() {
        let dt = DateTime(year: 2015, month: 12, day: 05, kind: .Utc, weekStarts: .Sunday)
        XCTAssertEqual(dt.DayOfWeek, DayOfWeeks.Saturday)
    }

    func test_DayOfWeeksReturnsSaturday2() {
        let dt = DateTime(year: 2015, month: 12, day: 05, kind: .Utc, weekStarts: .Monday)
        XCTAssertEqual(dt.DayOfWeek, DayOfWeeks.Saturday)
    }
    
    func test_DayOfYearReturns342() {
        let dt = DateTime(year: 2015, month: 12, day: 08, kind: .Utc, weekStarts: .Monday)
        XCTAssertEqual(dt.DayOfYear, 342)
    }
    
    func test_DayOfYearReturns184() {
        let dt = DateTime(year: 1991, month: 07, day: 03, kind: .Utc)
        XCTAssertEqual(dt.DayOfYear, 184)
    }
    
    func test_TimeOfDay() {
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = dt.TimeOfDay
        XCTAssertEqual(dt.Hour, Int(ts.Hours))
        XCTAssertEqual(dt.Minute, Int(ts.Minutes))
        XCTAssertEqual(dt.Second, Int(ts.Seconds))
        XCTAssertEqual(dt.Millisecond, Int(ts.Milliseconds))
        
    }
    
    func test_AddMutatingTimeSpan() {
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = TimeSpan(days: 1, hours: 1)
        dt.AddMutatingTimeSpan(ts)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 6)
        XCTAssertEqual(dt.Hour, 17)
    }
    
    func test_AddTimeSpan() {
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = TimeSpan(days: 1, hours: 1)
        let dt2 = dt.AddTimeSpan(ts)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 6)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt2.Hour, 17)
        XCTAssertEqual(dt.Hour, 16)
    }
    
    func test_AddMutatingDays() {
        let interval = TimeSpan(days: 1).Interval
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        dt.AddMutatingDays(1)
        XCTAssertEqual(originalInterval, dt.Interval - interval)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 6)
        XCTAssertEqual(dt.Hour, 16)
        XCTAssertEqual(dt.Minute, 42)
        XCTAssertEqual(dt.Second, 11)
        XCTAssertEqual(dt.Millisecond, 500)
    }
    
    func test_AddDays() {
        let interval = TimeSpan(days: 1).Interval
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        let dt2 = dt.AddDays(1)
        XCTAssertEqual(originalInterval, dt2.Interval - interval)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 6)
        XCTAssertEqual(dt2.Hour, 16)
        XCTAssertEqual(dt2.Minute, 42)
        XCTAssertEqual(dt2.Second, 11)
        XCTAssertEqual(dt2.Millisecond, 500)
    }
    
    func test_AddMutatingHours() {
        let interval = TimeSpan(hours: 1).Interval
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        dt.AddMutatingHours(1)
        XCTAssertEqual(originalInterval, dt.Interval - interval)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt.Hour, 17)
        XCTAssertEqual(dt.Minute, 42)
        XCTAssertEqual(dt.Second, 11)
        XCTAssertEqual(dt.Millisecond, 500)
    }
    
    func test_AddHours() {
        let interval = TimeSpan(hours: 1).Interval
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        let dt2 = dt.AddHours(1)
        XCTAssertEqual(originalInterval, dt2.Interval - interval)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 5)
        XCTAssertEqual(dt2.Hour, 17)
        XCTAssertEqual(dt2.Minute, 42)
        XCTAssertEqual(dt2.Second, 11)
        XCTAssertEqual(dt2.Millisecond, 500)
    }
    
    func test_AddMutatingMinutes() {
        let interval = TimeSpan(minutes: 1).Interval
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        dt.AddMutatingMinutes(1)
        XCTAssertEqual(originalInterval, dt.Interval - interval)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt.Hour, 16)
        XCTAssertEqual(dt.Minute, 43)
        XCTAssertEqual(dt.Second, 11)
        XCTAssertEqual(dt.Millisecond, 500)
    }
    
    func test_AddMinutes() {
        let interval = TimeSpan(minutes: 1).Interval
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        let dt2 = dt.AddMinutes(1)
        XCTAssertEqual(originalInterval, dt2.Interval - interval)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 5)
        XCTAssertEqual(dt2.Hour, 16)
        XCTAssertEqual(dt2.Minute, 43)
        XCTAssertEqual(dt2.Second, 11)
        XCTAssertEqual(dt2.Millisecond, 500)
    }
    
    func test_AddMutatingSeconds() {
        let interval = TimeSpan(seconds: 47).Interval
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        dt.AddMutatingSeconds(47)
        XCTAssertEqual(originalInterval, dt.Interval - interval)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt.Hour, 16)
        XCTAssertEqual(dt.Minute, 42)
        XCTAssertEqual(dt.Second, 58)
        XCTAssertEqual(dt.Millisecond, 500)
    }
    
    func test_AddSeconds() {
        let interval = TimeSpan(seconds: 47).Interval
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        let dt2 = dt.AddSeconds(47)
        XCTAssertEqual(originalInterval, dt2.Interval - interval)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 5)
        XCTAssertEqual(dt2.Hour, 16)
        XCTAssertEqual(dt2.Minute, 42)
        XCTAssertEqual(dt2.Second, 58)
        XCTAssertEqual(dt2.Millisecond, 500)
    }
    
    func test_AddMutatingMilliseconds() {
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        dt.AddMutatingMilliseconds(500)
        XCTAssertEqual(originalInterval, dt.Interval - 0.5)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt.Hour, 16)
        XCTAssertEqual(dt.Minute, 42)
        XCTAssertEqual(dt.Second, 12)
        XCTAssertEqual(dt.Millisecond, 0)
    }
    
    func test_AddMilliseconds() {
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Utc)
        let originalInterval = dt.Interval
        let dt2 = dt.AddMilliseconds(500)
        XCTAssertEqual(originalInterval, dt2.Interval - 0.5)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 5)
        XCTAssertEqual(dt2.Hour, 16)
        XCTAssertEqual(dt2.Minute, 42)
        XCTAssertEqual(dt2.Second, 12)
        XCTAssertEqual(dt2.Millisecond, 0)
    }
    
    func test_AddMutatingInterval() {
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = TimeSpan(days: 1, hours: 1)
        dt.AddMutatingInterval(ts.Interval)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 6)
        XCTAssertEqual(dt.Hour, 17)
    }
    
    func test_AddInterval() {
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = TimeSpan(days: 1, hours: 1)
        let dt2 = dt.AddInterval(ts.Interval)
        XCTAssertEqual(dt.Interval, dt2.Interval - ts.Interval)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 6)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt2.Hour, 17)
        XCTAssertEqual(dt.Hour, 16)
    }
    
    func test_IsLeapYear() {
        let dt = DateTime(year: 2001, kind: .Utc)
        XCTAssertEqual(dt.IsLeapYear(), false)
        let dt2 = DateTime(year: 2008, kind: .Utc)
        XCTAssertEqual(dt2.IsLeapYear(), true)
    }
    
    func test_IsDaylightSavingTime() {
        let dt = DateTime(year: 2015, month: 6, day: 12, kind: .Local)
        XCTAssertEqual(dt.IsDaylightSavingTime(), true)
        let dt2 = DateTime(year: 2015, month: 2, day: 12, kind: .Local)
        XCTAssertEqual(dt2.IsDaylightSavingTime(), false)
        let dt3 = DateTime(year: 2015, month: 6, day: 12, kind: .Utc)
        XCTAssertEqual(dt3.IsDaylightSavingTime(), false)
    }
    
    func test_Equals() {
        let dt1 = DateTime(year: 2015, month: 6, day: 12, hour: 14, minute: 22, kind: .Local, weekStarts: .Monday)
        let dt2 = DateTime(year: 2015, month: 6, day: 12, hour: 14, minute: 22, kind: .Local, weekStarts: .Monday)
        let dt3 = DateTime(year: 2015, month: 6, day: 12, hour: 14, minute: 21, kind: .Local, weekStarts: .Monday)
        let dt4 = DateTime(year: 2015, month: 6, day: 12, hour: 14, minute: 22, kind: .Utc, weekStarts: .Monday)
        let dt5 = DateTime(year: 2015, month: 6, day: 12, hour: 13, minute: 22, kind: .Utc, weekStarts: .Monday)
        XCTAssertTrue(dt1.Equals(dt2))
        XCTAssertFalse(dt1.Equals(dt3))
        XCTAssertTrue(dt1.Equals(dt5))
        XCTAssertFalse(dt1.Equals(dt4))
    }
    
    func test_ParseValid() {
        let dt = DateTime.Parse("2015-12-08", format: "yyyy-MM-dd")
        XCTAssertEqual(dt?.Year, 2015)
        XCTAssertEqual(dt?.Month, 12)
        XCTAssertEqual(dt?.Day, 8)
    }
    
    func test_ParseInvalid() {
        let dt = DateTime.Parse("sd", format: "yyyy-MM-dd")
        XCTAssertNil(dt)
    }
    
    func test_ParseValidUtc() {
        let dt = DateTime.Parse("2015-12-08", format: "yyyy-MM-dd", kind: .Utc)
        XCTAssertEqual(dt?.Year, 2015)
        XCTAssertEqual(dt?.Month, 12)
        XCTAssertEqual(dt?.Day, 8)
        XCTAssertEqual(dt?.Kind, .Utc)
    }
    
    func test_ParseValidLocal() {
        let dt = DateTime.Parse("2015-12-08", format: "yyyy-MM-dd", kind: .Local)
        XCTAssertEqual(dt?.Year, 2015)
        XCTAssertEqual(dt?.Month, 12)
        XCTAssertEqual(dt?.Day, 8)
        XCTAssertEqual(dt?.Kind, .Local)
    }
    
    func test_ParseValidSummerLocal() {
        let dt = DateTime.Parse("2015-05-08", format: "yyyy-MM-dd", kind: .Local)
        XCTAssertEqual(dt?.Year, 2015)
        XCTAssertEqual(dt?.Month, 05)
        XCTAssertEqual(dt?.Day, 8)
        XCTAssertEqual(dt?.Kind, .Local)
    }
    
    func test_ToString() {
        let dt = DateTime(year: 1999, month: 12, day: 1, hour: 15, minute: 44, second: 23, millisecond: 500, kind: .Local, weekStarts: .Monday)
        XCTAssertEqual(dt.ToString(.FULL), "1999-12-01 15:44:23.500")
        XCTAssertEqual(dt.ToString(.LONG), "1999-12-01 15:44:23")
        XCTAssertEqual(dt.ToString(.LongDate), "01. December, 1999.")
        XCTAssertEqual(dt.ToString(.MediumDate), "01. Dec, 1999.")
        XCTAssertEqual(dt.ToString(.MediumDateA), "Dec 01, 1999.")
        XCTAssertEqual(dt.ToString(.MediumTime), "3:44:23p.m.")
        XCTAssertEqual(dt.ToString(.MediumTimeM), "15:44:23")
        XCTAssertEqual(dt.ToString(.ShortDate), "01/12/99")
        XCTAssertEqual(dt.ToString(.ShortTime), "3:44p.m.")
        XCTAssertEqual(dt.ToString(.ShortTimeM), "15:44")
    }
    
    func test_ToStringDefault() {
        let dt = DateTime(year: 1999, month: 12, day: 1, hour: 15, minute: 44, second: 23, millisecond: 500, kind: .Local, weekStarts: .Monday)
        XCTAssertEqual(dt.ToString(), "1999-12-01 15:44:23.500")
    }
    
    func test_ToStringCustom() {
        let dt = DateTime(year: 1999, month: 12, day: 1, hour: 15, minute: 44, second: 23, millisecond: 500, kind: .Local, weekStarts: .Monday)
        XCTAssertEqual(dt.ToString("EEE, yyyy/MM/dd hh:mm:ss zzz"), "Wed, 1999/12/01 03:44:23 GMT")
    }
    
    func test_ToUtc() {
        let local = DateTime(year: 2001, month: 05, day: 7, hour: 14, minute: 44, second: 23, kind: .Local, weekStarts: .Monday)
        let utc = local.ToUtc()
        XCTAssertEqual(local.Hour, utc.Hour + 1)
    }
    
    func test_ToLocal() {
        let utc = DateTime(year: 2001, month: 05, day: 7, hour: 14, minute: 44, second: 23, kind: .Utc, weekStarts: .Monday)
        let local = utc.ToLocal()
        XCTAssertEqual(utc.Hour, local.Hour - 1)
    }
    
    func test_LocalToLocal() {
        let local1 = DateTime(year: 2001, month: 05, day: 7, hour: 14, minute: 44, second: 23, kind: .Local, weekStarts: .Monday)
        let local2 = local1.ToLocal()
        XCTAssertEqual(local1.Hour, local2.Hour)
    }
    
    func test_UtcTOUtc() {
        let utc1 = DateTime(year: 2001, month: 05, day: 7, hour: 14, minute: 44, second: 23, kind: .Utc, weekStarts: .Monday)
        let utc2 = utc1.ToUtc()
        XCTAssertEqual(utc1.Hour, utc2.Hour)
    }
    
    func test_Equatable() {
        let utc = DateTime(year: 2001, month: 05, day: 7, hour: 14, minute: 44, second: 23, kind: .Utc, weekStarts: .Monday)
        let local = DateTime(year: 2001, month: 05, day: 7, hour: 15, minute: 44, second: 23, kind: .Local, weekStarts: .Monday)
        let local2 = DateTime(year: 2001, month: 05, day: 7, hour: 16, minute: 44, second: 23, kind: .Local, weekStarts: .Monday)
        XCTAssertTrue(utc == local)
        XCTAssertTrue(local != local2)
        XCTAssertTrue(local2 > local)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
