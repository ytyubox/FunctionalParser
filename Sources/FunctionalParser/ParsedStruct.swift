public struct Q<T>:Equatable where T: Equatable {
    public init(_ value: T, _ next: String) {
        self.value = value
        self.next = next
    }
    
    public var value:T
    public var next:String
    public func map<U>(_ transform:(T) -> U) -> Q<U> {
        Q<U>(transform(value), next)
    }
}