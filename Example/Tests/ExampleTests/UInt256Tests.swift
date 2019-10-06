import XCTest
@testable import Example
import BigInt

final class UInt256Tests: XCTestCase {

    static var allTests = [
        ("testEmptyInitResultsInZero", testEmptyInitResultsInZero),
        ("testMax", testMax),
        ("testMin", testMin),
        ("testMinIsZero", testMinIsZero),
        ("testEquatable", testEquatable),
        ("testAddition", testAddition),
        ("testSubtraction", testSubtraction),
        ("testMultiplication", testMultiplication),
    ]

    func testEmptyInitResultsInZero() {
        XCTAssertEqual(UInt256().magnitude, 0)
    }

    func testMax() {
        XCTAssertEqual(
            UInt256.max.magnitude,
            UInt256Bound.maxValue
        )
    }

    func testMinIsZero() {
        XCTAssertEqual(
            UInt256.min,
            UInt256.zero
        )
    }

    func testMin() {
        XCTAssertEqual(
            UInt256.min.magnitude,
            UInt256Bound.minValue
        )

        XCTAssertEqual(
            UInt256.min,
            UInt256()
        )
    }


    // MARK: - Equatable
    func testEquatable() {
        XCTAssertEqual(UInt256(magnitude: 1), UInt256(magnitude: 1))
        XCTAssertNotEqual(UInt256(magnitude: 1), UInt256(magnitude: 2))
    }

    // MARK: AdditiveArithmetic & ExpressibleByIntegerLiteral
    func testAddition() {
        doTest(1, 1, expectedResult: 2, +)
        doTest(2, 3, expectedResult: 5, +)
    }

    func testSubtraction() {
        doTest(7, 5, expectedResult: 2, -)
        doTest(7, 7, expectedResult: 0, -)
    }

    // MARK: - Numeric
    func testMultiplication() {
        doTest(1, 1, expectedResult: 1, *)
        doTest(1, 2, expectedResult: 2, *)

        doTest(0, 1, expectedResult: 0, *)
        doTest(1, 0, expectedResult: 0, *)

        doTest(2, 3, expectedResult: 6, *)
        doTest(3, 2, expectedResult: 6, *)

        doTest(2, 5, expectedResult: 10, *)
        doTest(3, 5, expectedResult: 15, *)
        doTest(3, 7, expectedResult: 21, *)
    }
}

private extension UInt256Tests {
    func doTest<Result>(
        _ lhs: UInt256, _ rhs: UInt256,
        expectedResult: Result,
        _ combine: (UInt256, UInt256) -> Result
    ) where Result: Equatable {
        XCTAssertEqual(combine(lhs, rhs), expectedResult)
    }
}
