public protocol Logic {
    static var defaultValue:Output {get}
    associatedtype Output:NextAble, LosslessStringConvertible
    func satisfy(_:Character) -> Bool
    func transform<S:LosslessStringConvertible>(_:S) -> Output
}
public extension Logic where Output: Equatable,Output: CustomStringConvertible {
    func only(_ c:Character, expect: Output) -> Bool {
        guard satisfy(c) else {return false}
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
        self + c
    }
}
