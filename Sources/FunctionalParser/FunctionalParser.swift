
public typealias QS<T> = [Q<T>] where T:Equatable


public func parse<L,S>(_ str:S,_ logic:L) -> QS<L.Output>
    where L:Logic,S:LosslessStringConvertible {
        guard let c = str.description.first,
          logic.logic(c)
    else {return []}
    
        let str = str.description.dropFirst()
    return [Q(logic.transform(c), str)]
}

public func parse<L>(
          _ str:String,
        _ logic:L,
    with expect: L.Output) -> QS<L.Output>
where L:Logic,L.Output: Comparable {
    guard let c = str.first,
          logic.only(c, expect: expect)
    else {return []}
    
    let str = str.dropFirst()
    return [Q(logic.transform(c), str)]
}

public func parse<L,S>(_ str:S,some logic:L) -> QS<L.Output>
    where L:Logic, S: LosslessStringConvertible
{
    var str = str.description
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
