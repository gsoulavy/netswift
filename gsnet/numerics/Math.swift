//
//  Math.swift
//  Simple Arithmetic
//
//  Created by Gabor Soulavy on 04/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

enum MidpointRounding {
    case ToEven
    case AwayFromZero
}

class Math {
    
    static let PI: Double = M_PI
    static let π: Double = PI
    static let E: Double = M_E
    
    class func Sqrt(x: Int) -> Double {
        return sqrt(Double(x))
    }
    
    class func Sqrt(x: Double) -> Double {
        return sqrt(x)
    }
    
    class func Sqrt(x: Float) -> Float {
        return sqrt(x)
    }
    
    class func Sqrt(x: CGFloat) -> CGFloat {
        return sqrt(x)
    }
    
    class func Abs<T : SignedNumberType>(x: T) -> T {
        return abs(x)
    }
    
    private class func decimalPlaces(decimalPlaces: Int) -> Double {
        var result = 1.0
        if (decimalPlaces >= 0) {
            for _ in 0..<decimalPlaces {
                result *= 10
            }
        } else {
            for _ in 0..<abs(decimalPlaces) {
                result = result/10
            }
        }
        return result
    }
    
    class func Round(value: Double, _ digits: Int, _ midpointRounding : MidpointRounding = .ToEven) -> Double{
        let multiplier = Math.decimalPlaces(digits)
        var result: Int
        switch(midpointRounding){
        case .ToEven:
            let sign = (value < 0) ? -1 : 1
            if (trunc(value) % 2 == 0){
                result = Int(abs(value * multiplier) - 0.5) * sign
            } else {
                result = Int(abs(value * multiplier) + 0.5) * sign
            }
            return Double(result) / multiplier
        case .AwayFromZero:
            return round(multiplier * value)/multiplier
        }
    }
    
    class func Round(value: Float, _ digits: Int, _ midpointRounding : MidpointRounding = .ToEven) -> Float {
        let multiplier = Math.decimalPlaces(digits)
        var result: Int
        switch(midpointRounding){
        case .ToEven:
            let sign = (value < 0) ? -1 : 1
            if (trunc(value) % 2 == 0){
                result = Int(abs(value * Float(multiplier)) - 0.5) * sign
            } else {
                result = Int(abs(value * Float(multiplier)) + 0.5) * sign
            }
            return Float(result) / Float(multiplier)
        case .AwayFromZero:
            return round(Float(multiplier) * value)/Float(multiplier)
        }
    }
    
    
    class func Round(value: CGFloat, _ digits: Int, _ midpointRounding : MidpointRounding = .ToEven) -> CGFloat {
        let multiplier = Math.decimalPlaces(digits)
        var result: Int
        switch(midpointRounding){
        case .ToEven:
            let sign = (value < 0) ? -1 : 1
            if (trunc(value) % 2 == 0){
                result = Int(abs(value * CGFloat(multiplier)) - 0.5) * sign
            } else {
                result = Int(abs(value * CGFloat(multiplier)) + 0.5) * sign
            }
            return CGFloat(result) / CGFloat(multiplier)
        case .AwayFromZero:
            return round(CGFloat(multiplier) * value)/CGFloat(multiplier)
        }
    }
    
    class func Log(x: Int) -> Double {
        return log(Double(x))
    }
    
    class func Log(x: Double) -> Double {
        return log(x)
    }
    
    class func Log(x: Float) -> Float {
        return log(x)
    }
    
    class func Log(x: CGFloat) -> CGFloat {
        return log(x)
    }
    
    class func Log10(x: Int) -> Double {
        return log10(Double(x))
    }
    
    class func Log10(x: Double) -> Double {
        return log10(x)
    }
    
    class func Log10(x: Float) -> Float {
        return log10(x)
    }
    
    class func Log10(x: CGFloat) -> CGFloat {
        return log10(x)
    }
    
    class func Log2(x: Int) -> Double {
        return log2(Double(x))
    }
    
    class func Log2(x: Double) -> Double {
        return log2(x)
    }
    
    class func Log2(x: Float) -> Float {
        return log2(x)
    }
    
    class func Log2(x: CGFloat) -> CGFloat {
        return log2(x)
    }
    
    class func Exp(x: Int) -> Double {
        return exp(Double(x))
    }
    
    class func Exp(x: Double) -> Double {
        return exp(x)
    }
    
    class func Exp(x: Float) -> Float {
        return exp(x)
    }
    
    class func Exp(x: CGFloat) -> CGFloat {
        return exp(x)
    }
    
    class func Floor(x: Int) -> Double {
        return floor(Double(x))
    }
    
    class func Floor(x: Double) -> Double {
        return floor(x)
    }
    
    class func Floor(x: Float) -> Float {
        return floor(x)
    }
    
    class func Floor(x: CGFloat) -> CGFloat {
        return floor(x)
    }
    
    class func Ceiling(x: Int) -> Double {
        return ceil(Double(x))
    }
    
    class func Ceiling(x: Double) -> Double {
        return ceil(x)
    }
    
    class func Ceiling(x: Float) -> Float {
        return ceil(x)
    }
    
    class func Ceiling(x: CGFloat) -> CGFloat {
        return ceil(x)
    }
    
    class func Pow(value: Int, _ power: Int) -> Double {
        return pow(Double(value), Double(power))
    }
    
    class func Pow(value: Double, _ power: Double) -> Double {
        return pow(value, power)
    }
    
    class func Pow(value: Float, _ power: Float) -> Float {
        return pow(value, power)
    }
    
    class func Pow(value: CGFloat, _ power: CGFloat) -> CGFloat {
        return pow(value, power)
    }
    
    class func Sin(angle: Double) -> Double {
        return sin(angle)
    }
    
    class func Sin(angle: Float) -> Float {
        return sin(angle)
    }
    
    class func Sin(angle: CGFloat) -> CGFloat {
        return sin(angle)
    }
    
    class func Sinh(angle: Double) -> Double {
        return sinh(angle)
    }
    
    class func Sinh(angle: Float) -> Float {
        return sinh(angle)
    }
    
    class func Singh(angle: CGFloat) -> CGFloat {
        return sinh(angle)
    }
    
    class func Asin(x: Double) -> Double {
        return asin(x)
    }
    
    class func Asin(x: Float) -> Float {
        return asin(x)
    }
    
    class func Asin(x: CGFloat) -> CGFloat {
        return asin(x)
    }
    
    class func Cos(angle: Double) -> Double {
        return cos(angle)
    }
    
    class func Cos(angle: Float) -> Float {
        return cos(angle)
    }
    
    class func Cos(angle: CGFloat) -> CGFloat {
        return cos(angle)
    }
    
    class func Cosh(angle: Double) -> Double {
        return cosh(angle)
    }
    
    class func Cosh(angle: Float) -> Float {
        return cosh(angle)
    }
    
    class func Cosh(angle: CGFloat) -> CGFloat {
        return cosh(angle)
    }
    
    class func Acos(x: Double) -> Double {
        return acos(x)
    }
    
    class func Acos(x: Float) -> Float {
        return acos(x)
    }
    
    class func Acos(x: CGFloat) -> CGFloat {
        return acos(x)
    }
    
    class func Tan(angle: Double) -> Double {
        return tan(angle)
    }
    
    class func Tan(angle: Float) -> Float {
        return tan(angle)
    }
    
    class func Tan(angle: CGFloat) -> CGFloat {
        return tan(angle)
    }
    
    class func Tanh(angle: Double) -> Double {
        return tanh(angle)
    }
    
    class func Tanh(angle: Float) -> Float {
        return tanh(angle)
    }
    
    class func Tanh(angle: CGFloat) -> CGFloat {
        return tanh(angle)
    }
    
    class func Atan(x: Double) -> Double {
        return atan(x)
    }
    
    class func Atan(x: Float) -> Float {
        return atan(x)
    }
    
    class func Atan(x: CGFloat) -> CGFloat {
        return atan(x)
    }
    
    class func Atan2(x: Double, _ y: Double) -> Double {
        return atan2(x, y)
    }
    
    class func Truncate(x: Double) -> Double {
        return trunc(x)
    }
    
    class func Truncate(x: Float) -> Float {
        return trunc(x)
    }
    
    class func Truncate(x: CGFloat) -> CGFloat {
        return trunc(x)
    }
    
    class func Max<T : Comparable>(x: T, _ y: T) -> T {
        return max(x, y)
    }
    
    class func Min<T : Comparable>(x: T, _ y: T) -> T {
        return min(x, y)
    }
}
