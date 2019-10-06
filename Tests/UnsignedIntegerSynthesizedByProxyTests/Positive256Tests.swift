//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import XCTest
@testable import UnsignedIntegerSynthesizedByProxy
import BigInt

final class Positive256Tests: XCTestCase {

    static var allTests = [
        ("testEmptyInitResultsInOne", testEmptyInitResultsInOne),
        ("testMax", testMax),
        ("testMin", testMin),
    ]

    func testEmptyInitResultsInOne() {
        XCTAssertEqual(Positive256().magnitude, 1)
    }

    func testMin() {
        XCTAssertEqual(
            Positive256.min.magnitude,
            Positive256Bound.minValue
        )

        XCTAssertEqual(
            Positive256.min,
            Positive256()
        )
    }

    func testMax() {
        XCTAssertEqual(
            Positive256.max.magnitude,
            Positive256Bound.maxValue
        )
    }
}
