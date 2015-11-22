//
//  DateTimeTests.swift
//  gsnet
//
//  Created by Gabor Soulavy on 21/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import XCTest
@testable import gsnet

class DateTime_Tests: XCTestCase {
    
    var leap: DateTime! = nil
    var nonLeap: DateTime! = nil
    var saving: DateTime! = nil
    var nonSaving: DateTime! = nil
    
    var unspecSaving: DateTime! = nil
    var localSaving: DateTime! = nil
    var utcSaving: DateTime! = nil
    
    var unspecNonSaving: DateTime! = nil
    var localNonSaving: DateTime! = nil
    var utcNonSaving: DateTime! = nil
    
    let YEAR: Int = 1994
    let YEAR_LEAP: Int = 2008
    let YEAR_NON_LEAP: Int = 2005
    let MONTH: Int = 04
    let MONTH_SAVING: Int = 06
    let MONTH_NON_SAVING: Int = 12
    let DAY: Int = 02
    let HOUR: Int = 12
    let MIN: Int = 56
    let SEC: Int = 22
    let MIL: Int = 400

    override func setUp() {
        super.setUp()
        leap = DateTime(year: YEAR_LEAP, month: MONTH, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL)
        nonLeap = DateTime(year: YEAR_NON_LEAP, month: MONTH, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL)
        saving = DateTime(year: YEAR, month: MONTH_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL)
        nonSaving = DateTime(year: YEAR, month: MONTH_NON_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL)
        
        unspecSaving = DateTime(year: YEAR, month: MONTH_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL, dateTimeKind: .Unspecified)
        localSaving = DateTime(year: YEAR, month: MONTH_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL, dateTimeKind: .Local)
        utcSaving = DateTime(year: YEAR, month: MONTH_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL, dateTimeKind: .Utc)
        
        unspecNonSaving = DateTime(year: YEAR, month: MONTH_NON_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL, dateTimeKind: .Unspecified)
        localNonSaving = DateTime(year: YEAR, month: MONTH_NON_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL, dateTimeKind: .Local)
        utcNonSaving = DateTime(year: YEAR, month: MONTH_NON_SAVING, day: DAY, hour: HOUR, minute: MIN, second: SEC, milisecond: MIL, dateTimeKind: .Utc)
    }
    
    override func tearDown() {
        leap = nil
        nonLeap = nil
        saving = nil
        nonSaving = nil
        
        unspecSaving = nil
        localSaving = nil
        utcSaving = nil
        
        unspecNonSaving = nil
        localNonSaving = nil
        utcNonSaving = nil
        super.tearDown()
    }
    
    func test_IsLeapYear_2008_True(){
        XCTAssertEqual(leap.IsLeapYear, true)
    }
    
    func test_IsLeapYear_2005_False() {
        XCTAssertEqual(nonLeap.IsLeapYear, false)
    }
    
    func test_IsDaylightSavingTime_False() {
        XCTAssertEqual(nonSaving.DaylightSavingTime, 0)
        XCTAssertEqual(nonSaving.IsDaylightSavingTime, false)
    }
    
    func test_IsDaylightSavingTime_True() {
        XCTAssertEqual(saving.DaylightSavingTime, 3600000)
        XCTAssertEqual(saving.IsDaylightSavingTime, true)
    }
    
    func test_UTCDaylightSavingFactor() {
        XCTAssertEqual(utcSaving.UTCDaylightSavingFactor, 3600000)
        XCTAssertEqual(localSaving.UTCDaylightSavingFactor, 0)
        XCTAssertEqual(unspecSaving.UTCDaylightSavingFactor, 0)
        XCTAssertEqual(utcNonSaving.UTCDaylightSavingFactor, 0)
        XCTAssertEqual(localNonSaving.UTCDaylightSavingFactor, 0)
        XCTAssertEqual(unspecSaving.UTCDaylightSavingFactor, 0)
    }
    
    func test_Year() {
        XCTAssertEqual(utcSaving.Year, YEAR)
    }
    
    func test_Month() {
        XCTAssertEqual(utcSaving.Month, MONTH_SAVING)
    }
    
    func test_DAY() {
        XCTAssertEqual(utcSaving.Day, DAY)
    }
    
    func test_Hour() {
        XCTAssertEqual(utcSaving.Hour, HOUR)
    }
    
    func test_Min() {
        XCTAssertEqual(utcSaving.Minute, MIN)
    }
    
    func test_Second() {
        XCTAssertEqual(utcSaving.Second, SEC)
    }
    
    func test_Milisec() {
        XCTAssertEqual(utcSaving.Milisecond, MIL)
    }
    
    func test_DayOfWeek() {
        XCTAssertEqual(utcSaving.DayOfWeek, DayOfWeeks.Thursday)
    }
    
    func test_DayOfYear() {
        XCTAssertEqual(utcSaving.DayOfYear, 153)
    }
    
    func test_moveToRange_lessThanMin() {
        let valMin = DateTime.moveToRange(variable: -5, min: 0, max: 5)
        XCTAssertEqual(valMin, 0)
    }
    
    func test_Tickfunctionality() {
        let startTick = 629055972000000000
        let dateTime = DateTime(ticks: startTick, fromDateTimeKind: .Utc)
        XCTAssertEqual(dateTime.Ticks, startTick)
    }
    
    
    
    
    func test_Date() {
        let date = utcSaving.Date
        
        XCTAssertEqual(date.Year, YEAR)
        XCTAssertEqual(date.Month, MONTH_SAVING)
        XCTAssertEqual(date.Day, DAY)
        XCTAssertEqual(date.Hour, 0)
        XCTAssertEqual(date.Minute, 0)
        XCTAssertEqual(date.Second, 0)
        XCTAssertEqual(date.Milisecond, 0)
        XCTAssertEqual(date.nanosecond, 0)
    }
    
    func test_Now_Kind_Local(){
        let date = DateTime.Now
        
        XCTAssertEqual(date.Kind, DateTimeKind.Local)
    }
    
//    func test_UtcSaving_Ticks() {
//        XCTAssertEqual(utcSaving.TicksInFileTime, 629061585824000000)
//    }
//    
//    func test_UtcNonSaving_Ticks(){
//        XCTAssertEqual(utcNonSaving.Ticks, 629219697824000000)
//    }
    
    func test_DateTime_DatePartsFunctionality() {
        let year = 1942, month = 6, day = 11, hour = 12, minute = 45, second = 32, milisecond = 555
        let date = DateTime(year: year, month: month, day: day, hour: hour, minute: minute, second: second, milisecond: milisecond)
        XCTAssertEqual(date.Year, year)
        XCTAssertEqual(date.Month, month)
        XCTAssertEqual(date.Day, day)
        XCTAssertEqual(date.Hour, hour)
        XCTAssertEqual(date.Minute, minute)
        XCTAssertEqual(date.Second, second)
        XCTAssertEqual(date.Milisecond, milisecond)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
