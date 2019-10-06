import XCTest
@testable import AnyBinaryInteger
import BigInt

private typealias BigNumber = AnyBinaryInteger<BigUInt>

final class AnyBinaryIntegerTests: XCTestCase {

    // MARK: - Equatable
    func testEquatable() {
        XCTAssertEqual(BigNumber(magnitude: 1), BigNumber(magnitude: 1))
        XCTAssertNotEqual(BigNumber(magnitude: 1), BigNumber(magnitude: 2))
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

    func testNumericFailableInitExactly() {
        XCTAssertNil(AnyBinaryInteger<BigUInt>(exactly: -1))
    }

    static var allTests = [
        ("testEquatable", testEquatable),
        ("testAddition", testAddition),
        ("testSubtraction", testSubtraction),
        ("testMultiplication", testMultiplication),
        ("testNumericFailableInitExactly", testNumericFailableInitExactly),
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
