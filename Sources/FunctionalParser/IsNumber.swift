public struct IsNumber: Logic {
    public init() {}
    public typealias Output = UInt
    public static var defaultValue: UInt {0}
    public func logic(_ c: Character) -> Bool {
        return "1234567890".contains(c)
    }
    public func transform(_ s: String) -> Output {
        Output(s) ?? 0
    }
}
