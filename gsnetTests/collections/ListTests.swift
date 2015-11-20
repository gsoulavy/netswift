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

    func testCreateListAndAddElement_CountIsOne() {
        let list: List<int> = List<int>()
        list.Add(42)
        XCTAssertEqual(list.Count, 1)
    }
    
    func testCreateListAndRemoveElementFromThree_CountIsTwo() {
        let list: List<int> = List<int>()
        list.Add(42); list.Add(32); list.Add(12)
        XCTAssertEqual(list.Count, 3)
        list.RemoveAt(1)
        XCTAssertEqual(list.Count, 2)
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
