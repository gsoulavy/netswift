//
//  DateTimeKind.swift
//  gsnet
//
//  Created by Gabor Soulavy on 21/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public enum DateTimeKind : Int, CustomStringConvertible {
    case UTC, Local, Unspecified
    
    public var description: String {
        get {
            switch self {
            case .UTC:
                return "UTC"
            case .Local:
                return "Local"
            case .Unspecified:
                return "Unspecified"
            }
        }
    }
}