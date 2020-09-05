//
//  File.swift
//  
//
//  Created by 游宗諭 on 2020/9/5.
//

import XCTest
@testable import FunctionalParser
class IsTests:XCTestCase {
    func testIsNumber() {
        let isNumber = IsNumber()
        for i:UInt in 0...9 {
            let c = Character("\(i)")
            let logicResult = isNumber.logic(c)
            XCTAssertTrue(logicResult)
            let transformOutput = isNumber.transform("\(c)")
            XCTAssertEqual(transformOutput, i)
            let onlyResult = isNumber.only(c, expect: i)
            XCTAssertTrue(onlyResult)
        }
    }
    func testIsChar() throws {
       
        let logic = IsChar()
        for i:UInt8 in 32...126 {
            let c = Character(UnicodeScalar(i))
            XCTAssertTrue(logic.logic(c), "expect c:\(c) is a char, but fail")
            let onlyResult = logic.only(c, expect: c.description)
            XCTAssertTrue(onlyResult, "expect c:\(c) is a char, but fail")
        }
    }
}
