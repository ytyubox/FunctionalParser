struct Q<T>:Equatable where T: Equatable {
    internal init(_ value: T, _ next: String) {
        self.value = value
        self.next = next
    }
    
    var value:T
    var next:String
    func map<U>(_ transform:(T) -> U) -> Q<U> {
        Q<U>(transform(value), next)
    }
}
