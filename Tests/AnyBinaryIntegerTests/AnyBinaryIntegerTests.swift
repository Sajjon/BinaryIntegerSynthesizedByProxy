import XCTest
@testable import AnyBinaryInteger

final class AnyBinaryIntegerTests: XCTestCase {

    func testEquatable() {
        XCTAssertEqual(BigNumber(magnitude: 1), BigNumber(magnitude: 1))
        XCTAssertNotEqual(BigNumber(magnitude: 1), BigNumber(magnitude: 2))
    }

    func testAddition() {
        doTest(1, 1, expectedResult: 2, +)
        doTest(2, 3, expectedResult: 5, +)
    }

    func testSubtraction() {
        doTest(7, 5, expectedResult: 2, -)
        doTest(7, 7, expectedResult: 0, -)
    }

    static var allTests = [
        ("testEquatable", testEquatable),
        ("testAddition", testAddition),
        ("testSubtraction", testSubtraction),
    ]
}

private extension AnyBinaryIntegerTests {
    func doTest<Result>(
        _ lhs: BigNumber, _ rhs: BigNumber,
        expectedResult: Result,
        _ combine: (BigNumber, BigNumber) -> Result
    ) where Result: Equatable {
        XCTAssertEqual(combine(lhs, rhs), expectedResult)
    }
}
