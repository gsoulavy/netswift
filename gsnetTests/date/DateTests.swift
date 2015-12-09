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
    
    func test_AddMutatingInterval() {
        var dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = TimeSpan(days: 1, hours: 1)
        dt.AddMutatingInterval(ts)
        XCTAssertEqual(dt.Year, 2001)
        XCTAssertEqual(dt.Month, 12)
        XCTAssertEqual(dt.Day, 6)
        XCTAssertEqual(dt.Hour, 17)
    }
    
    func test_AddInterval() {
        let dt = DateTime(year: 2001, month: 12, day: 5, hour: 16, minute: 42, second: 11, millisecond: 500, kind: .Local)
        let ts = TimeSpan(days: 1, hours: 1)
        let dt2 = dt.AddInterval(ts)
        XCTAssertEqual(dt2.Year, 2001)
        XCTAssertEqual(dt2.Month, 12)
        XCTAssertEqual(dt2.Day, 6)
        XCTAssertEqual(dt.Day, 5)
        XCTAssertEqual(dt2.Hour, 17)
        XCTAssertEqual(dt.Hour, 16)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
