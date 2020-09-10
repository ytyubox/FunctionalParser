public struct IsNumber: Logic {
    public func transform<S>(_ s: S) -> UInt where S : LosslessStringConvertible {
        Output(s.description) ?? 0
    }
    
    public init() {}
    public typealias Output = UInt
    public static var defaultValue: UInt {0}
   
    public func satisfy(_ c: Character) -> Bool {
        return "1234567890".contains(c)
    }
}
