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
typealias P<T> = [Q<T>] where T:Equatable
func someDigit(_ str:String) -> P<UInt> {
    
    [parse(str, IsNumber())].compactMap{$0}
        
//    return []// UInt(i >= 0 ? i : 0)
}

//func someInt(_ str:String) ->Int {
//    var str = str
//    let c = str.removeFirst()
//
//}
protocol Logic {
    associatedtype Output
    func logic(_:Character) -> Bool
    func transform(_:String) -> Output
}
func parse<L>(_ str:String,_ logic:L) -> Q<L.Output>?
where L:Logic
{
    var o = [Character]()
    var copy = str
    for c in str {
        guard logic.logic(c) else  {
            break
        }
        o.append(copy.removeFirst())
    }
    if o.isEmpty {return nil}
    let v = String(o)
    return Q(logic.transform(v), copy)
}

struct IsNumber: Logic {
    typealias Output = UInt
    func logic(_ c: Character) -> Bool {
        return "1234567890".contains(c)
    }
    func transform(_ s: String) -> Output {
        Output(s) ?? 0
    }
}
