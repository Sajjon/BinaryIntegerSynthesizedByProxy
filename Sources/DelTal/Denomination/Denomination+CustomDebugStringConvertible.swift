//
//  File.swift
//
//
//  Created by Alexander Cyon on 2019-10-06.
//


import Foundation

extension Denomination: CustomDebugStringConvertible {}
public extension Denomination {
    
    var debugDescription: String {
        return [
            String(describing: exponent),
            name,
            symbol,
            exponentSuperscript,
            String(describing: decimalValue)
        ].joined(separator: " | ")
    }
    
    var exponentSuperscript: String {
        return "10\(exponent.superscriptString())"
    }
    
    var decimalValue: Decimal {
        do {
            return try Decimal.ten(toThePowerOf: exponent)
        } catch { incorrectImplementationShouldAlwaysBeAble(to: "Calculate decimal of denomination", error) }
    }
}

extension Int {
    
    func superscriptString() -> String {
        let minusPrefixOrEmpty: String = self < 0 ? Superscript.minus : ""
        let (quotient, remainder) = abs(self).quotientAndRemainder(dividingBy: 10)
        let quotientString = quotient > 0 ? quotient.superscriptString() : ""
        return minusPrefixOrEmpty + quotientString + Superscript.value(remainder)
    }
}

enum Superscript {
    static let minus = "⁻"
    private static let values: [String] = [
        "⁰",
        "¹",
        "²",
        "³",
        "⁴",
        "⁵",
        "⁶",
        "⁷",
        "⁸",
        "⁹"
    ]
    
    static func value(_ int: Int) -> String {
        assert(int >= 0 && int <= 9)
        return values[int]
    }
}
