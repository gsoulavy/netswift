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
        let dt2: DateTime = DateTime(rDTicks: dt1.RDTicks, kind: .Utc)
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
        let dt2: DateTime = DateTime(rDTicks: dt1.RDTicks, kind: .Local)
        XCTAssertEqual(dt1.Year, dt2.Year)
        XCTAssertEqual(dt1.Month, dt2.Month)
        XCTAssertEqual(dt1.Day, dt2.Day)
        XCTAssertEqual(dt1.Hour, dt2.Hour)
        XCTAssertEqual(dt1.Minute, dt2.Minute)
        XCTAssertEqual(dt1.Second, dt2.Second)
        XCTAssertEqual(dt1.Millisecond, dt2.Millisecond)
    }

    func test_InitDtTick_Utc() {
        let dt: DateTime = DateTime(dTTicks: 618700000000000000, kind: .Utc)
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
        XCTAssertEqual(dt.DTTicks, 618700000000000000)
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

    func test_LDAPTicks_Prop_Utc() {
        let dt = DateTime(year: 1961, month: 04, day: 01, hour: 12, minute: 55, second: 22, millisecond: 555, kind: DateTimeKind.Utc);
        XCTAssertEqual(dt.LDAP, 113682993225550000)
    }

//    func test_UtcNonSaving_Ticks(){
//        XCTAssertEqual(utcNonSaving.Ticks, 629219697824000000)
//    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
