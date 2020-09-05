//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/9/4.
//

import Foundation

protocol Logic {
    static var defaultValue:Output {get}
    associatedtype Output:NextAble
    func logic(_:Character) -> Bool
    func transform(_:String) -> Output
}
extension Logic where Output: Equatable,Output: CustomStringConvertible {
    func only(_ c:Character, expect: Output) -> Bool {
        guard logic(c) else {return false}
        return expect.description == c.description
    }
}

protocol NextAble {
    func next() -> Self
    func add(_:Self) -> Self
}

extension UInt:NextAble{
    func next() -> UInt {
        self * 10
    }
    func add(_ v: UInt) -> UInt {
        self + v
    }
}

extension String: NextAble {
    func next() -> String {
        self
    }
    func add(_ c: String) -> String{
        self + String(c)
    }
}
