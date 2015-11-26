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
        
        let dt: Date = Date(year: 2001, month: 01, day: 01)
        XCTAssertNotNil(dt as Date)
    }
    
    func test_GetYear_Month_Day_BackFromInit() {
        let year = 2001
        let month = 02
        let day = 03
        let dt: Date = Date(year: year, month: month, day: day)
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
        let dt: Date = Date(year: year, month: month, day: day, hour: hour, minute: min, second: sec, millisecond: millisecond, kind: .Local)
        XCTAssertEqual(dt.Year, year)
        XCTAssertEqual(dt.Month, month)
        XCTAssertEqual(dt.Day, day)
        XCTAssertEqual(dt.Hour, hour)
        XCTAssertEqual(dt.Minute, min)
        XCTAssertEqual(dt.Second, sec)
        XCTAssertEqual(dt.Millisecond, millisecond)
    }
    
    func test_GetKindFromDate() {
        let dt: Date = Date(year: 2001, month: 01, day: 01, kind: .Local)
        XCTAssertEqual(dt.Kind, DateTimeKind.Local)
        let dt2: Date = Date(year: 2001, month: 02, day: 02, kind: .Utc)
        XCTAssertEqual(dt2.Kind, DateTimeKind.Utc)
        let dt3: Date = Date(year: 2001, month: 03, day: 04)
        XCTAssertEqual(dt3.Kind, DateTimeKind.Local)
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
