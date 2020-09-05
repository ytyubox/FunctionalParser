
public typealias QS<T> = [Q<T>] where T:Equatable


public func parse<L>(_ str:String,_ logic:L) -> QS<L.Output>
where L:Logic {
    guard let c = str.first,
          logic.logic(c)
    else {return []}
    
    let str = str.dropFirst().description
    return [Q(logic.transform(c.description), str)]
}

public func parse<L>(
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

public func parse<L>(_ str:String,some logic:L) -> QS<L.Output>
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
