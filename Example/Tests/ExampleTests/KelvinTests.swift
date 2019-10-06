//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import XCTest
@testable import Example
import BigInt

final class KelvinTests: XCTestCase {
    static var allTests = [
        ("testMeltTemperatur", testMeltTemperatur),
        ("testKelvinDescription", testKelvinDescription),
    ]

    func testMeltTemperatur() {
        XCTAssertEqual(Kelvin.Water.meltsAt, 273)
        XCTAssertEqual(Kelvin.Water.boilsAt - Kelvin.Water.meltsAt, 100)
    }

    func testKelvinDescription() {
        XCTAssertEqual(Kelvin.Water.boilsAt.description, "373 Kelvin")
        XCTAssertEqual(Kelvin.Water.boilsAt.debugDescription, "373 Kelvin (Temperature)")
    }
}
