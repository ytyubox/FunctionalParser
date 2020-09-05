public protocol Logic {
    static var defaultValue:Output {get}
    associatedtype Output:NextAble
    func logic(_:Character) -> Bool
    func transform(_:String) -> Output
}
public extension Logic where Output: Equatable,Output: CustomStringConvertible {
    func only(_ c:Character, expect: Output) -> Bool {
        guard logic(c) else {return false}
        return expect.description == c.description
    }
}

public protocol NextAble {
    func next() -> Self
    func add(_:Self) -> Self
}

extension UInt:NextAble{
    public func next() -> UInt {
        self * 10
    }
    public func add(_ v: UInt) -> UInt {
        self + v
    }
}

extension String: NextAble {
    public func next() -> String {
        self
    }
    public func add(_ c: String) -> String{
        self + String(c)
    }
}
