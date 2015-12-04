//
//  ListTests.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import XCTest
@testable import gsnet

class ListTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCount_OneElement_One() {
        let list: List<int> = List<int>()
        list.Add(42)
        XCTAssertEqual(list.Count, 1)
    }

    func testCount_TwoElements_CountIsTwo() {
        let list: List<int> = List<int>()
        list.Add(42); list.Add(32); list.Add(12)
        XCTAssertEqual(list.Count, 3)
        list.RemoveAt(1)
        XCTAssertEqual(list.Count, 2)
    }

    func testStartIndex_ReturnsAlwaysZero() {
        let list: List<int> = List<int>()
        XCTAssertEqual(0, list.startIndex)
        list.Add(1)
        XCTAssertEqual(0, list.startIndex)
    }

    func testEndIndex_WithEmptyList_ReturnsZero() {
        let list: List<int> = List<int>()
        XCTAssertEqual(0, list.endIndex)
    }

    func testEndIndex_TwoElements_ReturnsTwo() {
        let list: List<int> = List<int>()
        list.Add(1)
        list.Add(33)
        XCTAssertEqual(2, list.endIndex)
    }

    func testArray_TwoElements_RetursTwo() {
        let list = [1, 2]
        XCTAssertEqual(2, list.endIndex)
    }

    func testList_TwoElements_LoopsTwiceInForEach() {
        let list = List<int>()
        list.Add(23); list.Add(2)
        var counter = 0
        for _ in list {
            counter++
        }
        XCTAssertEqual(2, counter)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
