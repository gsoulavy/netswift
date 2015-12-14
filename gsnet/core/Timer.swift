//
//  Timer.swift
//  gsnet
//
//  Created by Gabor Soulavy on 14/12/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

import Foundation

public class Timer {
    private var _timer: NSTimer?
    private var _interval: NSTimeInterval
    private var _callback: () -> ()
    private var _repeats: Bool
    
    public init(callback: () -> (), interval: NSTimeInterval, repeats: Bool){
        _callback = callback
        _interval = interval
        _repeats = repeats

    }
    
    @objc private func Callback(){
        _callback()
    }
}

public extension Timer {
    public func Start() {
        _timer = NSTimer.scheduledTimerWithTimeInterval(_interval, target: self, selector: Selector("Callback"), userInfo: nil, repeats: _repeats)
    }
    
    public func Stop(){
        _timer?.invalidate()
    }
}