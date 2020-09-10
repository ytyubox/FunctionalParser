public struct MathParser {
    public init() { }
    public func nat<S:LosslessStringConvertible>(_ str:S) -> QS<UInt> {
        parse(str,some: IsNumber())
    }
    
    public func int(_ str:String) -> QS<Int> {
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
            let str = str.dropFirst()
            let qs =
                self.nat(str).map{
                    q in
                    q.map{Int($0)}}
            guard let q = qs.first else {return []}
            return [q.map{$0 * -1}]
        }
    }
    /// (x) -> x
    /// do char '('
    ///   x <- expr
    ///   char '('
    ///   return x
    ///<|> int
    ///
    ///
    ///
    ///
    public func factor(_ str:String) -> QS<Int> {
        guard !str.isEmpty else {return []}
        let charLogic = IsChar()
        guard
            let leading = parse(str, charLogic, with: "(").first,
            let int = int(leading.next).first,
            let trailing = parse(int.next, charLogic, with: ")").first,
            trailing.next == ""
        else {
            return []
        }
        return [Q(int.value,"")]
    }
    
    public func expr(_ str: String) -> QS<Int> {
        []
    }
    public func term(_ str: String) -> QS<Int> {
        []
    }
}
