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
