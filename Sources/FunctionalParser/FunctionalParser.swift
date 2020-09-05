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
}
//typealias Q<T> = (T, String)
typealias QS<T> = [Q<T>] where T:Equatable
func someDigit(_ str:String) -> QS<UInt> {
    
    //    [
    parse(str,some: IsNumber())
    //    ].compactMap{$0}
    
    //    return []// UInt(i >= 0 ? i : 0)
}

//func someInt(_ str:String) ->Int {
//    var str = str
//    let c = str.removeFirst()
//
//}

func parse<L>(_ str:String,_ logic:L) -> QS<L.Output>
where L:Logic {
    guard let c = str.first,
          logic.logic(c)
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


struct IsNumber: Logic {
    typealias Output = UInt
    static var defaultValue: UInt {0}
    func logic(_ c: Character) -> Bool {
        return "1234567890".contains(c)
    }
    func transform(_ s: String) -> Output {
        Output(s) ?? 0
    }
}
