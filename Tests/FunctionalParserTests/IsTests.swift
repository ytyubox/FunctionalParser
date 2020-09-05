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
        }
    }
    func testIsChar() throws {
        let A = try XCTUnwrap(Character("A").asciiValue)
        let Z = try XCTUnwrap(Character("Z").asciiValue)
        let a = try XCTUnwrap(Character("a").asciiValue)
        let z = try XCTUnwrap(Character("z").asciiValue)
        let logic = IsChar()
        for i in A...Z {
            let c = Character(UnicodeScalar(i))
            XCTAssertTrue(logic.logic(c))
        }
        for j in a...z {
            let c = Character(UnicodeScalar(j))
            XCTAssertTrue(logic.logic(c))
        }
    }
}
