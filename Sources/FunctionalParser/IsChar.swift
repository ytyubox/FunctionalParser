public struct IsChar:Logic {
    public func transform<S>(_ s: S) -> String where S : LosslessStringConvertible {
        Output(s)
    }
    
    
    public static var defaultValue: String {""}
    public typealias Output = String
    public func logic(_ c: Character) -> Bool {
        c.asciiValue != nil
    }
}
