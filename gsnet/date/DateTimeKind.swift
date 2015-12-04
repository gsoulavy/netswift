//
//  DateTimeKind.swift
//  gsnet
//
//  Created by Gabor Soulavy on 21/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public enum DateTimeKind: Int, CustomStringConvertible {
    case Unspecified = 0, Utc = 1, Local = 2

    public var description: String {
        get {
            switch self {
            case .Utc:
                return "UTC"
            case .Local:
                return "Local"
            case .Unspecified:
                return "Unspecified"
            }
        }
    }
}