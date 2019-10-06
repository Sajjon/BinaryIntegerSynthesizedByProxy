//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
@testable import BinaryIntegerSynthesizedByProxy

private typealias UI32 = AnyInteger<UInt32>

import XCTest

class UInt32ViaProxyTests: XCTestCase {

    static var allTests = [
        ("testCompareMagnitudeToUInt32", testCompareMagnitudeToUInt32),
        ("testEquatable", testEquatable),
        ("testAddition", testAddition),
        ("testSubtraction", testSubtraction),
        ("testMultiplication", testMultiplication),
    ]

    func testCompareMagnitudeToUInt32() {
        XCTAssertEqual(UI32.zero.magnitude, UInt32.zero.magnitude)
        XCTAssertEqual(UI32(1).magnitude, UInt32(1).magnitude)
    }

    // MARK: - Equatable
    func testEquatable() {
        XCTAssertEqual(UI32(magnitude: 1), UI32(magnitude: 1))
        XCTAssertNotEqual(UI32(magnitude: 1), UI32(magnitude: 2))
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

private extension UInt32ViaProxyTests {
    func doTest<Result>(
        _ lhs: UI32, _ rhs: UI32,
        expectedResult: Result,
        _ combine: (UI32, UI32) -> Result
    ) where Result: Equatable {
        XCTAssertEqual(combine(lhs, rhs), expectedResult)
    }
}
