//
//  ReadOnlyList.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

/// Stack collection class [18 Nov 2015 21:14]
/// ###Methods:
/// - Push
/// - Pop
/// - Peek
/// - Clear

public class Stack<Element> {
    private var items = [Element]()

    public func Push(item: Element) {
        items.append(item)
    }

    public func Pop() -> Element? {
        if let _ = Peek() {
            return items.removeLast()
        }
        return nil
    }

    public func Peek() -> Element? {
        return items.last
    }

    public func Clear() {
        items.removeAll()
    }
}