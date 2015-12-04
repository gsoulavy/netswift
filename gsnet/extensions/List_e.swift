//
//  List_e.swift
//  gsnet
//
//  Created by Gabor Soulavy on 19/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

extension List where T:Equatable {

    public func Where(function: (T) -> Bool) -> List<T> {
        let result = List<T>()
        for item in self.items {
            if function(item) {
                result.Add(item)
            }
        }
        return result
    }
}