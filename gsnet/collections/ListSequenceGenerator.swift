//
//  ListSequenceGenerator.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

public class ListSequenceGenerator<T: Equatable>: GeneratorType {
    let _value: [T]
    var indexInSequence = 0
    
    init(value: [T]){
        self._value = value
    }
    
    public func next() -> T? {
        for index in indexInSequence..<_value.endIndex {
            indexInSequence++
            return _value[index]
        }
        return nil
    }
}