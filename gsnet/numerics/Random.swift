//
//  Random.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public class Random {

    internal var _seed: uint = 0
    internal let _isSeedProvided: Bool

    public init() {
        _isSeedProvided = false
    }

    public init(seed: uint) {
        _seed = seed
        _isSeedProvided = true
    }

    public func Next() -> int {
        return int(arc4random_uniform(uint(int.max)))
    }

    func Next(upper: int) -> int {
        return int(arc4random_uniform(uint(upper)))
    }

    func Next(minValue: int, _ maxValue: int) -> int {
        return self.Next(maxValue - minValue + 1) + minValue
    }

    func Next(inout bytesArray: [byte]) -> [byte] {
        for var index = 0; index < bytesArray.count; index++ {
            bytesArray[index] = byte(arc4random_uniform(uint(255)))
        }
        return bytesArray
    }

    public func Sample() -> double {
        return double(float(arc4random()) / float(uint.max))
    }

    func NextDouble() -> double {
        return double(arc4random()) / double(0xFFFFFFFF)
    }

    func NextFloat() -> float {
        return float(arc4random()) / float(0xFFFFFFFF)
    }

    func NextCGFloat() -> CGFloat {
        return CGFloat(float(arc4random()) / float(0xFFFFFFFF))
    }
}
