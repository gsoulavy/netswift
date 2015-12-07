//
//  TimeSpanTests.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import XCTest
@testable import gsnet

class TimeSpanTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_TicksInSecond_Returns_1() {
        XCTAssertEqual(TimeSpan.TICKS_IN_SECOND, 1)
        
    }
    
    func test_TicksInMinute_Returns_60() {
        XCTAssertEqual(TimeSpan.TICKS_IN_MINUTE, 60)
    }
    
    func test_TicksInHour_Returns_3600() {
        XCTAssertEqual(TimeSpan.TICKS_IN_HOUR, 3600)
    }
    
    func test_TicksInDay_Returns_86400() {
        XCTAssertEqual(TimeSpan.TICKS_IN_DAY, 86400)
    }
    
    func test_TicksInMillisecond_Returns_0DOT001() {
        XCTAssertEqual(TimeSpan.TICKS_IN_MILLISECOND, 0.001)
    }
    
    func test_TicksInNanosecond_Returns_0DOT000000001() {
        XCTAssertEqual(TimeSpan.TICKS_IN_NANOSECOND, 0.000000001)
    }
    
    func test_Tick86400_Returns_1_day() {
        let ts = TimeSpan(ticks: 86400)
        XCTAssertEqual(ts.Days, 1)
        XCTAssertEqual(ts.Hours, 0)
        XCTAssertEqual(ts.Minutes, 0)
        XCTAssertEqual(ts.Seconds, 0)
        XCTAssertEqual(ts.Milliseconds, 0)
        XCTAssertEqual(ts.Nanoseconds, 0)
    }
    
    func test_Tick3600_Returns_1_Hour() {
        let ts = TimeSpan(ticks: 3600)
        XCTAssertEqual(ts.Days, 0)
        XCTAssertEqual(ts.Hours, 1)
        XCTAssertEqual(ts.Minutes, 0)
        XCTAssertEqual(ts.Seconds, 0)
        XCTAssertEqual(ts.Milliseconds, 0)
        XCTAssertEqual(ts.Nanoseconds, 0)
    }
    
    func test_Tick60_Returns_1_Minute() {
        let ts = TimeSpan(ticks: 60)
        XCTAssertEqual(ts.Days, 0)
        XCTAssertEqual(ts.Hours, 0)
        XCTAssertEqual(ts.Minutes, 1)
        XCTAssertEqual(ts.Seconds, 0)
        XCTAssertEqual(ts.Milliseconds, 0)
        XCTAssertEqual(ts.Nanoseconds, 0)
    }
    
    func test_Tick81_Returns_1_second() {
        let ts = TimeSpan(ticks: 1)
        XCTAssertEqual(ts.Days, 0)
        XCTAssertEqual(ts.Hours, 0)
        XCTAssertEqual(ts.Minutes, 0)
        XCTAssertEqual(ts.Seconds, 1)
        XCTAssertEqual(ts.Milliseconds, 0)
        XCTAssertEqual(ts.Nanoseconds, 0)
    }
    
    func test_Tick0DOT001_Returns_1_milli() {
        let ts = TimeSpan(ticks: 0.001)
        XCTAssertEqual(ts.Days, 0)
        XCTAssertEqual(ts.Hours, 0)
        XCTAssertEqual(ts.Minutes, 0)
        XCTAssertEqual(ts.Seconds, 0)
        XCTAssertEqual(ts.Milliseconds, 1)
        XCTAssertEqual(ts.Nanoseconds, 0)
    }
    
    func test_Tick0DOT000000001_Returns_1_nano() {
        let ts = TimeSpan(ticks: 0.000000001)
        XCTAssertEqual(ts.Days, 0)
        XCTAssertEqual(ts.Hours, 0)
        XCTAssertEqual(ts.Minutes, 0)
        XCTAssertEqual(ts.Seconds, 0)
        XCTAssertEqual(ts.Milliseconds, 0)
        XCTAssertEqual(ts.Nanoseconds, 1)
    }
    
    func test_TickCombined90060DOT001000001_ReturnsCombined() {
        let ts = TimeSpan(ticks: 90061.001000010)
        XCTAssertEqual(ts.Days, 1)
        XCTAssertEqual(ts.Hours, 1)
        XCTAssertEqual(ts.Minutes, 1)
        XCTAssertEqual(ts.Seconds, 1)
        XCTAssertEqual(ts.Milliseconds, 1)
        XCTAssertEqual(ts.Nanoseconds, 10)
    }
    
    func test_TickReturns90061FOT001000010(){
        let ts = TimeSpan(days: 1, hours: 1, minutes: 1, seconds: 1, milliseconds: 1, nanoseconds: 10)
        XCTAssertEqual(ts.Ticks, 90061.001000010)
    }
    
    func test_TotalSecondsReturns3661(){
        let ts = TimeSpan(days: 0, hours: 1, minutes: 1, seconds: 1, milliseconds: 0, nanoseconds: 0)
        XCTAssertEqual(ts.TotalSeconds, 3661)
    }
    
    func test_TotalMinutesReturns84MinutesInADay() {
        let ts = TimeSpan(days: 1)
        XCTAssertEqual(ts.TotalMinutes, 1440)
    }
    
    func test_TotalHoursReturns48HoursInADay() {
        let ts = TimeSpan(days: 2)
        XCTAssertEqual(ts.TotalHours, 48)
    }
    
    func test_TotalDaysReturns2DaysIn48Hours() {
        let ts = TimeSpan(hours: 48)
        XCTAssertEqual(ts.TotalDays, 2)
        XCTAssertEqual(ts.TotalHours, 48)
        XCTAssertEqual(ts.Hours, 0)
        XCTAssertEqual(ts.Days, 2)
    }
    
    func test_DurationNegative() {
        let ts1 = TimeSpan(ticks: -3600)
        XCTAssertEqual(ts1.Hours, -1)
        let ts2 = ts1.Duration()
        XCTAssertEqual(ts2.Hours, 1)
    }
    
    func test_DurationPositive() {
        let ts1 = TimeSpan(ticks: 3600)
        XCTAssertEqual(ts1.Hours, 1)
        let ts2 = ts1.Duration()
        XCTAssertEqual(ts2.Hours, 1)
    }
    
    func test_NegateNegative() {
        let ts1 = TimeSpan(ticks: -3600)
        XCTAssertEqual(ts1.Hours, -1)
        let ts2 = ts1.Negate()
        XCTAssertEqual(ts2.Hours, 1)
    }
    
    func test_NegatePositive() {
        let ts1 = TimeSpan(ticks: 3600)
        XCTAssertEqual(ts1.Hours, 1)
        let ts2 = ts1.Negate()
        XCTAssertEqual(ts2.Hours, -1)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
