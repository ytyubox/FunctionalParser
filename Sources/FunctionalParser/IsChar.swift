public struct IsChar:Logic {
    
    public static var defaultValue: String {""}
    public typealias Output = String
    public func transform(_: String) -> Output {
        "0"
    }
    public func logic(_ c: Character) -> Bool {
        c.asciiValue != nil
    }
}
