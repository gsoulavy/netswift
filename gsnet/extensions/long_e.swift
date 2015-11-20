//
//  long_e.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

extension long : ValueType {
    
    public static func Parse(s:String) -> long?{
        return long(s)
    }
    
    public func ToString() -> String {
        return String(self)
    }
}