//import XCTest
//@testable import AnyBinaryInteger
//import BigInt
//
//private typealias BigNumber = Integer<BigUInt>
//
//extension BigNumber {
//    static func of(_ proxy: Proxy) -> Self {
//        return .init(proxy: proxy)
//    }
//}
//
//final class BinaryIntegerSynthesizedByProxyTests: XCTestCase {
//
//    // MARK: - Equatable
//    func testEquatable() {
//
//        XCTAssertEqual(
//            BigNumber.of(1),
//            BigNumber.of(1)
//        )
//
//        XCTAssertEqual(
//            BigNumber.of(0),
//            BigNumber.of(0)
//        )
//
//        XCTAssertNotEqual(
//            BigNumber.of(1),
//            BigNumber.of(2)
//        )
//    }
//
//    // MARK: AdditiveArithmetic & ExpressibleByIntegerLiteral
//    func testAddition() {
//        doTest(BigNumber.of(1), BigNumber.of(1), expectedResult: BigNumber.of(2), +)
//        doTest(BigNumber.of(2), BigNumber.of(3), expectedResult: BigNumber.of(5), +)
//    }
//
//    func testSubtraction() {
//        doTest(BigNumber.of(7), BigNumber.of(5), expectedResult: BigNumber.of(2), -)
//        doTest(BigNumber.of(7), BigNumber.of(7), expectedResult: BigNumber.of(0), -)
//    }
//
//    // MARK: - Numeric
//    func testMultiplication() {
//        doTest(BigNumber.of(1), BigNumber.of(1), expectedResult: BigNumber.of(1), *)
//        doTest(BigNumber.of(1), BigNumber.of(2), expectedResult: BigNumber.of(2), *)
//
//        doTest(BigNumber.of(0), BigNumber.of(1), expectedResult: BigNumber.of(0), *)
//        doTest(BigNumber.of(1), BigNumber.of(0), expectedResult: BigNumber.of(0), *)
//
//        doTest(BigNumber.of(2), BigNumber.of(3), expectedResult: BigNumber.of(6), *)
//        doTest(BigNumber.of(3), BigNumber.of(2), expectedResult: BigNumber.of(6), *)
//
//        doTest(BigNumber.of(2), BigNumber.of(5), expectedResult: BigNumber.of(10), *)
//        doTest(BigNumber.of(3), BigNumber.of(5), expectedResult: BigNumber.of(15), *)
//        doTest(BigNumber.of(3), BigNumber.of(7), expectedResult: BigNumber.of(21), *)
//    }
////
////    func testNumericFailableInitExactly() {
////        XCTAssertNil(AnyBinaryInteger<BigUInt>(exactly: -BigNumber.of(1)))
////        XCTAssertNotNil(AnyBinaryInteger<BigInt>(exactly: -BigNumber.of(1)))
////    }
//
//    static var allTests = [
//        ("testEquatable", testEquatable),
//        ("testAddition", testAddition),
//        ("testSubtraction", testSubtraction),
//        ("testMultiplication", testMultiplication),
////        ("testNumericFailableInitExactly", testNumericFailableInitExactly),
//    ]
//}
//
//private extension BinaryIntegerSynthesizedByProxyTests {
//    func doTest<Result>(
//        _ lhs: BigNumber, _ rhs: BigNumber,
//        expectedResult: Result,
//        _ combine: (BigNumber, BigNumber) -> Result
//    ) where Result: Equatable {
//        XCTAssertEqual(combine(lhs, rhs), expectedResult)
//    }
//}
