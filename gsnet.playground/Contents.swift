//: Playground - noun: a place where people can play

import Cocoa
@testable import gsnet
import XCPlayground

//var page = XCPlaygroundPage.currentPage
//page.needsIndefiniteExecution = true

var count = 0

func delegate() {
    count++;
    print(DateTime.Now)
}

var timer = Timer(callback: delegate, interval: 5, repeats: true)

timer.Start()
timer.Stop()
//var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("delegate"), userInfo: nil, repeats: true)