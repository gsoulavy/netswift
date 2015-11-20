//
//  Random.swift
//  gsnet
//
//  Created by Gabor Soulavy on 20/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public class Random {
    
    internal var _seed: uint = 0
    let _isSeedProvided: Bool
    
    public init(){
        _isSeedProvided = false
    }
    
    public init(seed: uint){
        _seed = seed
        _isSeedProvided = true
    }
    
    public func Next() -> int {
        return int(arc4random_uniform(uint(int.max)))
    }
}
