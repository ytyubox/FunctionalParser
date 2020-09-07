public struct IsChar:Logic {
    public func transform<S>(_: S) -> String where S : LosslessStringConvertible {
        "0"
    }
    
    
    public static var defaultValue: String {""}
    public typealias Output = String
    public func logic(_ c: Character) -> Bool {
        c.asciiValue != nil
    }
}
