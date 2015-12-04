//
//  ReadOnlyList.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

/// List collection class [18 Nov 2015 21:14]

public class ReadOnlyList<T:Equatable>: SequenceType, CollectionType {
    var items: [T]

    public var Count: Int {
        get {
            return items.count
        }
    }

    public var Capacity: Int {
        get {
            return items.capacity
        }
    }

    public convenience init() {
        self.init(array: [T]())
    }

    public init(array: [T]) {
        items = array
    }

    public subscript(index: Int) -> T {
        get {
            return items[index]
        }
    }

    public func Contains(item: T) -> Bool {
        return items.contains(item)
    }

    public var startIndex: Int {
        return 0
    }

    public var endIndex: Int {
        return items.count
    }

    public func generate() -> ListSequenceGenerator<T> {
        return ListSequenceGenerator(value: items)
    }

    public func Where(function: (T) -> Bool) -> ReadOnlyList<T> {
        let result = List<T>()
        for item in items {
            if function(item) {
                result.Add(item)
            }
        }
        return ReadOnlyList(array: result.AsArray())
    }
}