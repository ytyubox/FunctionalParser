import Foundation
struct FunctionalParser {
    var text = "Hello, World!"
}

protocol ParserProtocol {
    func parse(_ str:String) -> Bool
}
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
//typealias Q<T> = (T, String)
typealias QS<T> = [Q<T>] where T:Equatable

struct MathParser {
    
    
    func nat(_ str:String) -> QS<UInt> {
        parse(str,some: IsNumber())
    }
    
    func int(_ str:String) -> QS<Int> {
        if str.isEmpty {return []}
        let q_of_sign = parse(str, IsChar(),
                               with: "-")
        let isNat = q_of_sign.isEmpty
        switch isNat {
        case true:
            return self.nat(str).map{
                q in
                q.map{Int($0)}}
        case false:
            let str = str.dropFirst().description
            let qs =
                self.nat(str).map{
                    q in
                    q.map{Int($0)}}
            guard let q = qs.first else {return []}
            return [q.map{$0 * -1}]
        }
    }
}

func parse<L>(_ str:String,_ logic:L) -> QS<L.Output>
where L:Logic {
    guard let c = str.first,
          logic.logic(c)
    else {return []}
    
    let str = str.dropFirst().description
    return [Q(logic.transform(c.description), str)]
}
func parse<L>(
          _ str:String,
        _ logic:L,
    with expect: L.Output) -> QS<L.Output>
where L:Logic,L.Output: Comparable, L.Output: CustomStringConvertible {
    guard let c = str.first,
          logic.only(c, expect: expect)
    else {return []}
    
    let str = str.dropFirst().description
    return [Q(logic.transform(c.description), str)]
}
func parse<L>(_ str:String,some logic:L) -> QS<L.Output>
where L:Logic
{
    var str = str
    var value:L.Output = L.defaultValue
    var _qs = [Q<L.Output>]()
    while true {
        let qs = parse(str, logic)
        guard let q = qs.first else {
            return _qs
        }
        value =  value.next()
        value = value.add(q.value)
        str = q.next
        _qs = [Q(value, str)]
    }
}
