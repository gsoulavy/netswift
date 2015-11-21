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

    func testTimeSpan_1day_10hours_2minutes_5seconds() {
        
        let ts = TimeSpan(days: 1,hours: 10,minutes: 2,seconds: 5,miliseconds: 500)
        print(TimeSpan.TicksPerMilisecond)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ts.Ticks, 1225255000000)
    }
    
    func testTimeSpan_FromMiliseconds(){
        
        let ts = TimeSpan(ticks: 1225255000000)
        
        XCTAssertEqual(ts.Hours, 10)
        XCTAssertEqual(ts.Minutes, 2)
        XCTAssertEqual(ts.Seconds, 5)
        XCTAssertEqual(ts.Miliseconds, 500)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
