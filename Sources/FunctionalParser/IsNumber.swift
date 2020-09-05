//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/9/5.
//


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
