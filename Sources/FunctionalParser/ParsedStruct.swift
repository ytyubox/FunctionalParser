public struct Q<T>:Equatable, CustomStringConvertible
where T: Equatable {
    public init(_ value: T, _ next: LosslessStringConvertible) {
        self.value = value
        self.next = next.description
    }
    
    public var value:T
    public var next:String
    public func map<U>(_ transform:(T) -> U) -> Q<U> {
        Q<U>(transform(value), next)
    }
    public var description: String {"\(value), \(next)"}
}
