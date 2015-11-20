//
//  String_e.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

extension String
{    
    public var Length: Int {
        get {
            return self.characters.count
        }
    }
    
    func Reverse() -> String {
        let chars = Array(self.characters).reverse()
        var reversed = ""
        for char in chars {
            reversed.append(char)
        }
        return reversed
    }
}