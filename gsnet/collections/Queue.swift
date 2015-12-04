//
//  ReadOnlyList.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

/// Stack collection class [18 Nov 2015 21:14]
/// ###Methods:
/// - Enqueue
/// - Dequeue
/// - Peek
/// - Clear

public class Queue<Element> {
    private var items = [Element]()

    public func Enqueue(item: Element) {
        items.append(item)
    }

    public func Dequeue() -> Element? {
        if let _ = Peek() {
            return items.removeFirst()
        }
        return nil
    }

    public func Peek() -> Element? {
        return items.first
    }

    public func Clear() {
        items.removeAll()
    }
}