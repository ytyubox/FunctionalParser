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
        let charLogic = IsChar()
        guard
            let leading = parse(str, charLogic, with: "(").first,
            let int = expr(leading.next).first,
            let trailing = parse(int.next, charLogic, with: ")").first
        else {
            return self.int(str)
        }
        return [Q(int.value,trailing.next)]
    }
    
    /// (2*1)
    /// do x <- term
    ///   char '*'
    ///   y <- term
    ///   return (x*y)
    /// <|> factor
    public func term(_ str: String) -> QS<Int> {
        guard
            let leading = self.factor(str).first,
            let times = parse(leading.next, IsChar(), with: "*").first,
            let trailing = self.term(times.next).first
        else {
            return self.factor(str)
        }
        return [Q(leading.value * trailing.value,trailing.next)]
    }
    /// 1 + 1
    ///
    ///
    /// do     x < term
    ///     char '+'
    ///     y <- expr
    ///     return (x+y)
    /// <|> term
    ///
    ///
    ///
    ///
    ///
    public func expr(_ str: String) -> QS<Int> {
        guard
            let leading = self.term(str).first,
            let times = parse(leading.next, IsChar(), with: "+").first,
            let trailing = self.expr(times.next).first
        else {
            return self.term(str)
        }
        let value = leading.value + trailing.value
        return [Q(value,trailing.next)]
    }
}
