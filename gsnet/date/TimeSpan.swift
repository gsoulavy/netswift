//
//  TimeSpan.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public struct TimeSpan {
    private var _tick: Double

    private var _days: Double = 0
    private var _hours: Double = 0
    private var _minutes: Double = 0
    private var _seconds: Double = 0
    private var _miliseconds: Double = 0

    private var _hoursReminder: Double = 0
    private var _minutesReminder: Double = 0
    private var _secondsReminder: Double = 0

    private static let MILISECOND: Double = 1000
    private static let SECOND: Double = 60
    private static let MINUTE: Double = 60
    private static let HOUR: Double = 24

    internal static let TicksPerDay: Double = 86400000
    internal static let TicksPerHour: Double = TimeSpan.TicksPerDay / TimeSpan.HOUR
    internal static let TicksPerMinute: Double = TimeSpan.TicksPerHour / TimeSpan.MINUTE
    internal static let TicksPerSecond: Double = TimeSpan.TicksPerMinute / TimeSpan.SECOND
    internal static let TicksPerMilisecond: Double = TimeSpan.TicksPerSecond / TimeSpan.MILISECOND

    var Days: Int {
        get {
            return Int(trunc(_days))
        }
    }

    var TotalDays: Double {
        get {
            return self.TotalHours / TimeSpan.HOUR
        }
    }

    var Hours: Int {
        get {
            return Int(_hours)
        }
    }

    var TotalHours: Double {
        get {
            return self.TotalMinutes / TimeSpan.MINUTE
        }
    }

    var Minutes: Int {
        get {
            return Int(self._minutes)
        }
    }

    var TotalMinutes: Double {
        get {
            return self.TotalSeconds / TimeSpan.SECOND
        }
    }

    var Seconds: Int {
        get {
            return Int(self._seconds)
        }
    }

    var TotalSeconds: Double {
        get {
            return TotalMiliseconds / TimeSpan.MILISECOND
        }
    }

    var Miliseconds: Int {
        get {
            return Int(self._miliseconds)
        }
    }

    var TotalMiliseconds: Double {
        get {
            return _tick
        }
    }

    var nanoseconds: Int {
        get {
            return Miliseconds * 1000000
        }
    }

    public var Ticks: Int {
        get {
            return Int(_tick) * 10000
        }
    }

    public init(ticks: Int) {
        _tick = Double(ticks / 10000)

        let days = TimeSpan.GetUnitsAndReminder(_tick, unit: TimeSpan.TicksPerDay)
        _days = days.whole
        _hoursReminder = days.reminder

        let hours = TimeSpan.GetUnitsAndReminder(_hoursReminder, unit: TimeSpan.TicksPerHour)
        _hours = hours.whole
        _minutesReminder = hours.reminder

        let minutes = TimeSpan.GetUnitsAndReminder(_minutesReminder, unit: TimeSpan.TicksPerMinute)
        _minutes = minutes.whole
        _secondsReminder = minutes.reminder

        let seconds = TimeSpan.GetUnitsAndReminder(_secondsReminder, unit: TimeSpan.TicksPerSecond)
        _seconds = seconds.whole
        _miliseconds = seconds.reminder

    }

    public init(hours: Int, minutes: Int, seconds: Int) {
        self.init(ticks: hours * Int(TimeSpan.TicksPerHour) + minutes * Int(TimeSpan.TicksPerMinute) + seconds * Int(TimeSpan.TicksPerSecond))
    }

    public init(days: Int, hours: Int, minutes: Int, seconds: Int) {
        self.init(ticks: days * Int(TimeSpan.TicksPerDay) +
                hours * Int(TimeSpan.TicksPerHour) + minutes * Int(TimeSpan.TicksPerMinute) + seconds * Int(TimeSpan.TicksPerSecond))
    }

    public init(days: Int, hours: Int, minutes: Int, seconds: Int, miliseconds: Int) {
        self.init(ticks: days * Int(TimeSpan.TicksPerDay) +
                hours * Int(TimeSpan.TicksPerHour) + minutes * Int(TimeSpan.TicksPerMinute) + seconds * Int(TimeSpan.TicksPerSecond) + miliseconds * Int(TimeSpan.TicksPerMilisecond))
    }

    private static func GetUnitsAndReminder(big: Double, unit: Double) -> (whole:Double, reminder:Double) {
        let whole = trunc(big / unit)
        let reminder = big % unit
        return (whole, reminder)
    }

    func Add(ts: TimeSpan) -> TimeSpan {
        return TimeSpan(ticks: ts.Ticks + Int(_tick))
    }

    static func Compare(ts1: TimeSpan, _ ts2: TimeSpan) -> Int {
        return ts1.CompareTo(ts2)
    }

    func CompareTo(ts: TimeSpan) -> Int {
        switch (self, ts) {
        case _ where self.Ticks < ts.Ticks:
            return -1
        case _ where self.Ticks == ts.Ticks:
            return 0
        default:
            return 1
        }
    }

    func Duration() -> TimeSpan {
        return TimeSpan(ticks: abs(self.Ticks))
    }

    func Negative() -> TimeSpan {
        return TimeSpan(ticks: -self.Ticks)
    }

    func Equals(ts: TimeSpan) -> Bool {
        return (self.Ticks == ts.Ticks)
    }

    static func Equals(ts1: TimeSpan, ts2: TimeSpan) -> Bool {
        return ts1.Equals(ts2)
    }

    static func FromDays(value: Double) -> TimeSpan {
        let tick = value * TicksPerDay
        return TimeSpan(ticks: Int(tick))
    }

    static func FromHours(value: Double) -> TimeSpan {
        let tick = value * TicksPerHour
        return TimeSpan(ticks: Int(tick))
    }

    static func FromMinutes(value: Double) -> TimeSpan {
        let tick = value * TicksPerMinute
        return TimeSpan(ticks: Int(tick))
    }

    static func FromSeconds(value: Double) -> TimeSpan {
        let tick = value * TicksPerSecond
        return TimeSpan(ticks: Int(tick))
    }

    static func FromMiliseconds(value: Double) -> TimeSpan {
        let tick = value * TicksPerMilisecond
        return TimeSpan(ticks: Int(tick))
    }

    static func FromTicks(value: Double) -> TimeSpan {
        return TimeSpan(ticks: Int(value))
    }

    func Subtract(ts: TimeSpan) -> TimeSpan {
        return TimeSpan(ticks: self.Ticks - ts.Ticks)
    }
}

func +(left: TimeSpan, right: TimeSpan) -> TimeSpan {
    return TimeSpan(ticks: left.Ticks + right.Ticks)
}

func -(left: TimeSpan, right: TimeSpan) -> TimeSpan {
    return TimeSpan(ticks: left.Ticks - right.Ticks)
}

func *(left: TimeSpan, right: Double) -> TimeSpan {
    return TimeSpan(ticks: Int(Double(left.Ticks) * right))
}

func *(left: Double, right: TimeSpan) -> TimeSpan {
    return TimeSpan(ticks: Int(left * Double(right.Ticks)))
}

func /(left: TimeSpan, right: TimeSpan) -> Double {
    return Double(left.Ticks / right.Ticks)
}

func /(left: TimeSpan, right: Double) -> TimeSpan {
    return TimeSpan(ticks: Int(Double(left.Ticks) / right))
}

func ==(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Ticks == right.Ticks)
}

func !=(left: TimeSpan, right: TimeSpan) -> Bool {
    return !(left.Ticks == right.Ticks)
}

func <(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Ticks < right.Ticks)
}

func >(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Ticks > right.Ticks)
}

func <=(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Ticks <= right.Ticks)
}

func >=(left: TimeSpan, right: TimeSpan) -> Bool {
    return (left.Ticks >= right.Ticks)
}

prefix func -(timeSpan: TimeSpan) -> TimeSpan {
    return TimeSpan(ticks: -timeSpan.Ticks)
}

func +=(inout left: TimeSpan, right: TimeSpan) {
    left = left + right
}

func -=(inout left: TimeSpan, right: TimeSpan) {
    left = left - right
}

func *=(inout left: TimeSpan, right: Double) {
    left = left * right
}

func /=(inout left: TimeSpan, right: Double) {
    left = left / right
}
