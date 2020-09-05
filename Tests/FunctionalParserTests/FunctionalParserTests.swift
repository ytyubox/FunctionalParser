import XCTest
@testable import FunctionalParser

final class FunctionalParserTests: XCTestCase {
   
    func test_parse_success() throws {
        let logic = IsNumber()
        let parseResult = try XCTUnwrap(parse("123", logic).first)
        
        
        XCTAssertEqual(parseResult.value, 1)
        XCTAssertEqual(parseResult.next, "23")
    }
    func test_parse_failure() throws {
        let logic = IsNumber()
        let parseResult = parse("abc", logic)
        XCTAssertTrue(parseResult.isEmpty)
    }
    
    func test_parse_some_success() throws {
        let logic = IsNumber()
        let parseResult = try XCTUnwrap(parse("123", some: logic).first)
        
        
        XCTAssertEqual(parseResult.value, 123)
        XCTAssertEqual(parseResult.next, "")
    }
    func test_parse_Will_some_failure_with_nothing_success() throws {
        let logic = IsNumber()
        
        let parseResult = parse("abc", some: logic)
        XCTAssertTrue(parseResult.isEmpty, "should be empty but fonud: \(parseResult)")
        
    }
    func test_parse_Will_some_failure_with_prefix_success() throws {
        let logic = IsNumber()
        let parseResult = try XCTUnwrap(parse("1abc", some: logic).first)
        XCTAssertEqual(parseResult.value, 1)
        XCTAssertEqual(parseResult.next, "abc")
        
    }
  
    func testSomeDigit() {
        XCTAssertEqual(someDigit("123"), [Q(123,"")])
        XCTAssertEqual(someDigit("1abc"), [Q(1,"abc")])
        XCTAssertEqual(someDigit("-123"), [])
    }
    
}

