import XCTest
@testable import AnyBinaryInteger

final class AnyBinaryIntegerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(AnyBinaryInteger().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
