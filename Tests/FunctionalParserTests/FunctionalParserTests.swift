import XCTest
import FunctionalParser

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
  
    func testNat() {
        let p = MathParser()
        XCTAssertEqual(p.nat("123"), [Q(123,"")])
        XCTAssertEqual(p.nat("1abc"), [Q(1,"abc")])
        XCTAssertEqual(p.nat("-123"), [])
        XCTAssertEqual(p.nat("abc"), [])
    }
    func testInt() {
        let p = MathParser()
        XCTAssertEqual(p.int("123"), [Q(123,"")])
        XCTAssertEqual(p.int("1abc"), [Q(1,"abc")])
        XCTAssertEqual(p.int("-123"), [Q(-123,"")])
        XCTAssertEqual(p.int("abc"), [])
    }
}

