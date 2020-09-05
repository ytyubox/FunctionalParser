//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/9/5.
//

import Foundation



struct IsChar:Logic {
    
    static var defaultValue: String {""}
    typealias Output = String
    func transform(_: String) -> Output {
        "0"
    }
    func logic(_ c: Character) -> Bool {
        c.asciiValue != nil
    }
}
