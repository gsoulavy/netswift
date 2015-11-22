//
//  Math.swift
//  Simple Arithmetic
//
//  Created by Gabor Soulavy on 04/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public enum MidpointRounding {
    case ToEven
    case AwayFromZero
}

public class Math {
    
    public static let PI: Double = M_PI
    public static let π: Double = PI
    public static let E: Double = M_E
    
    public class func Sqrt(x: Int) -> Double {
        return sqrt(Double(x))
    }
    
    public class func Sqrt(x: Double) -> Double {
        return sqrt(x)
    }
    
    public class func Sqrt(x: Float) -> Float {
        return sqrt(x)
    }
    
    public class func Sqrt(x: CGFloat) -> CGFloat {
        return sqrt(x)
    }
    
    public class func Abs<T : SignedNumberType>(x: T) -> T {
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
    
    public class func Round(value: Double, _ digits: Int, _ midpointRounding : MidpointRounding = .ToEven) -> Double {
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
    
    public class func Round(value: Float, _ digits: Int, _ midpointRounding : MidpointRounding = .ToEven) -> Float {
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
    
    
    public class func Round(value: CGFloat, _ digits: Int, _ midpointRounding : MidpointRounding = .ToEven) -> CGFloat {
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
    
    public class func Log(x: Int) -> Double {
        return log(Double(x))
    }
    
    public class func Log(x: Double) -> Double {
        return log(x)
    }
    
    public class func Log(x: Float) -> Float {
        return log(x)
    }
    
    public class func Log(x: CGFloat) -> CGFloat {
        return log(x)
    }
    
    public class func Log10(x: Int) -> Double {
        return log10(Double(x))
    }
    
    public class func Log10(x: Double) -> Double {
        return log10(x)
    }
    
    public class func Log10(x: Float) -> Float {
        return log10(x)
    }
    
    public class func Log10(x: CGFloat) -> CGFloat {
        return log10(x)
    }
    
    public class func Log2(x: Int) -> Double {
        return log2(Double(x))
    }
    
    public class func Log2(x: Double) -> Double {
        return log2(x)
    }
    
    public class func Log2(x: Float) -> Float {
        return log2(x)
    }
    
    public class func Log2(x: CGFloat) -> CGFloat {
        return log2(x)
    }
    
    public class func Exp(x: Int) -> Double {
        return exp(Double(x))
    }
    
    public class func Exp(x: Double) -> Double {
        return exp(x)
    }
    
    public class func Exp(x: Float) -> Float {
        return exp(x)
    }
    
    public class func Exp(x: CGFloat) -> CGFloat {
        return exp(x)
    }
    
    public class func Floor(x: Int) -> Double {
        return floor(Double(x))
    }
    
    public class func Floor(x: Double) -> Double {
        return floor(x)
    }
    
    public class func Floor(x: Float) -> Float {
        return floor(x)
    }
    
    public class func Floor(x: CGFloat) -> CGFloat {
        return floor(x)
    }
    
    public class func Ceiling(x: Int) -> Double {
        return ceil(Double(x))
    }
    
    public class func Ceiling(x: Double) -> Double {
        return ceil(x)
    }
    
    public class func Ceiling(x: Float) -> Float {
        return ceil(x)
    }
    
    public class func Ceiling(x: CGFloat) -> CGFloat {
        return ceil(x)
    }
    
    public class func Pow(value: Int, _ power: Int) -> Double {
        return pow(Double(value), Double(power))
    }
    
    public class func Pow(value: Double, _ power: Double) -> Double {
        return pow(value, power)
    }
    
    public class func Pow(value: Float, _ power: Float) -> Float {
        return pow(value, power)
    }
    
    public class func Pow(value: CGFloat, _ power: CGFloat) -> CGFloat {
        return pow(value, power)
    }
    
    public class func Sin(angle: Double) -> Double {
        return sin(angle)
    }
    
    public class func Sin(angle: Float) -> Float {
        return sin(angle)
    }
    
    public class func Sin(angle: CGFloat) -> CGFloat {
        return sin(angle)
    }
    
    public class func Sinh(angle: Double) -> Double {
        return sinh(angle)
    }
    
    public class func Sinh(angle: Float) -> Float {
        return sinh(angle)
    }
    
    public class func Singh(angle: CGFloat) -> CGFloat {
        return sinh(angle)
    }
    
    public class func Asin(x: Double) -> Double {
        return asin(x)
    }
    
    public class func Asin(x: Float) -> Float {
        return asin(x)
    }
    
    public class func Asin(x: CGFloat) -> CGFloat {
        return asin(x)
    }
    
    public class func Cos(angle: Double) -> Double {
        return cos(angle)
    }
    
    public class func Cos(angle: Float) -> Float {
        return cos(angle)
    }
    
    public class func Cos(angle: CGFloat) -> CGFloat {
        return cos(angle)
    }
    
    public class func Cosh(angle: Double) -> Double {
        return cosh(angle)
    }
    
    public class func Cosh(angle: Float) -> Float {
        return cosh(angle)
    }
    
    public class func Cosh(angle: CGFloat) -> CGFloat {
        return cosh(angle)
    }
    
    public class func Acos(x: Double) -> Double {
        return acos(x)
    }
    
    public class func Acos(x: Float) -> Float {
        return acos(x)
    }
    
    public class func Acos(x: CGFloat) -> CGFloat {
        return acos(x)
    }
    
    public class func Tan(angle: Double) -> Double {
        return tan(angle)
    }
    
    public class func Tan(angle: Float) -> Float {
        return tan(angle)
    }
    
    public class func Tan(angle: CGFloat) -> CGFloat {
        return tan(angle)
    }
    
    public class func Tanh(angle: Double) -> Double {
        return tanh(angle)
    }
    
    public class func Tanh(angle: Float) -> Float {
        return tanh(angle)
    }
    
    public class func Tanh(angle: CGFloat) -> CGFloat {
        return tanh(angle)
    }
    
    public class func Atan(x: Double) -> Double {
        return atan(x)
    }
    
    public class func Atan(x: Float) -> Float {
        return atan(x)
    }
    
    public class func Atan(x: CGFloat) -> CGFloat {
        return atan(x)
    }
    
    public class func Atan2(x: Double, _ y: Double) -> Double {
        return atan2(x, y)
    }
    
    public class func Truncate(x: Double) -> Double {
        return trunc(x)
    }
    
    public class func Truncate(x: Float) -> Float {
        return trunc(x)
    }
    
    public class func Truncate(x: CGFloat) -> CGFloat {
        return trunc(x)
    }
    
    public class func Max<T : Comparable>(x: T, _ y: T) -> T {
        return max(x, y)
    }
    
    public class func Min<T : Comparable>(x: T, _ y: T) -> T {
        return min(x, y)
    }
}
