import XCTest
@testable import FunctionalParser

final class FunctionalParserTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(FunctionalParser().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
