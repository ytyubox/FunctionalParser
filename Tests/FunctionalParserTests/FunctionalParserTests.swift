import XCTest
@testable import FunctionalParser

final class FunctionalParserTests: XCTestCase {
    //    func testSomeInt() {
    //        XCTAssertEqual(someInt("123"), 123)
    //        XCTAssertEqual(someInt("1abc"), 1)
    //        XCTAssertEqual(someInt("-123"), -123)
    //
    //    }
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
    func test_parse_success() throws {
        let logic = IsNumber()
        let parseResult = try XCTUnwrap(parse("123", logic))
        
        
        XCTAssertEqual(parseResult.value, 123)
        XCTAssertEqual(parseResult.next, "")
    }
    func test_parse_Will_failure() throws {
        let logic = IsNumber()
        let parseResult = try XCTUnwrap(parse("1abc", logic))
        XCTAssertEqual(parseResult.value, 1)
        XCTAssertEqual(parseResult.next, "abc")
    }
    func testSomeDigit() {
        XCTAssertEqual(someDigit("123"), [Q(123,"")])
        XCTAssertEqual(someDigit("1abc"), [Q(1,"abc")])
        XCTAssertEqual(someDigit("-123"), [])
    }
    
}

