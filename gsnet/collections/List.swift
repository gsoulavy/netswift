//
//  ReadOnlyList.swift
//  gsnet
//
//  Created by Gabor Soulavy on 18/11/2015.
//  Copyright © 2015 Gabor Soulavy. All rights reserved.
//

/// List collection class [18 Nov 2015 21:14]
public class List<T: Equatable> : SequenceType, CollectionType {
    internal var items: [T]
    
    public var Count : Int {
        get { return items.count }
    }
    
	public var Capacity: Int {
        get { return items.capacity }
    }
    
    public convenience init(){
        self.init(array: [T]())
    }
    
    public init(array: [T]){
        items = array
    }
    
    public subscript(index: Int) -> T {
        get { return items[index] }
        set(value) {
            items[index] = value
        }
    }
    
    public func AsArray() -> [T] {
        return items
    }
    
    public func AsReadOnly() -> ReadOnlyList<T> {
        return ReadOnlyList(array: self.AsArray())
    }
    
    public func Add(item: T) {
        items.append(item)
    }
    
    public func AddRange(list: List<T>){
        items.appendContentsOf(list)
    }
    
    public func Clear(){
        items.removeAll()
    }
    
    public func Contains(item: T) -> Bool{
        return items.contains(item)
    }
    
    public func Insert(index: Int, item: T) {
        items.insert(item, atIndex: index)
    }
    
    public func InsertRange(index: Int, list: List<T>) {
        items.insertContentsOf(list, at: index)
    }
    
    public func Remove(item: T) {
        if let i = items.indexOf(item){
            items.removeAtIndex(i)
        }
    }
    
    public func RemoveAt(index: Int) {
        items.removeAtIndex(index)
    }
    
    public func Reverse() {
        items = items.reverse()
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
}