//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import BigInt

/// The different denominations of Radix, only the `exponent` value is used for equals and comparison.
///
/// Defining common denominations, see [list on wiki][1]
///
/// [1]: https://en.wikipedia.org/wiki/Metric_prefix#List_of_SI_prefixes
///
public struct Denomination: Hashable, CustomStringConvertible {

    /// The important value, the exponent to raise `10` to the power of, e.g. the decimal value of this denomination value is `10^{exponent}`
    public let exponent: Int

    public let name: String
    public let symbol: String

    public init(exponent: Int, name: String, symbol: String) throws {

        self.exponent = exponent
        self.name = name
        self.symbol = symbol
    }
}

// MARK: - Error
public extension Denomination {
    enum Error: Swift.Error, Equatable {

        case amountNotRepresentableAsIntegerInDenomination(
            amount: BigUInt,
            fromDenomination: Denomination,
            toDenomination: Denomination
        )
    }
}

// MARK: - Hashable
public extension Denomination {
    func hash(into hasher: inout Hasher) {
        hasher.combine(exponent)
    }
}

// MARK: - Presets

// swiftlint:disable colon comma
public extension Denomination {
    static var exa          : Self { .init(18, s: "E") }
    static var peta         : Self { .init(15, s: "P") }
    static var tera         : Self { .init(12, s: "T") }
    static var giga         : Self { .init(9,  s: "G") }
    static var mega         : Self { .init(6,  s: "M") }
    static var kilo         : Self { .init(3,  s: "k") }
    static var hecto        : Self { .init(2,  s: "h") }
    static var deca         : Self { .init(1,  s: "da") }

    /// This is the standard denomination of all UserActions.
    static var whole        : Self { .init(0,   s: "1") }

    static var deci         : Self { .init(-1,  s: "d") }
    static var centi        : Self { .init(-2,  s: "c") }
    static var milli        : Self { .init(-3,  s: "m") }
    static var micro        : Self { .init(-6,  s: "μ") }
    static var nano         : Self { .init(-9,  s: "n") }
    static var pico         : Self { .init(-12, s: "p") }
    static var femto        : Self { .init(-15, s: "f") }

    /// `atto` with an exponent of `-18` is the smallest possible denomination of Radix. The Radix Core / Radix Engine uses this in all `Particle`.
    /// In other words, in the end all amounts will be converted to `atto` and sent to the a Node's API.
    static var atto         : Self { .init(-18, s: "a") }
}

// swiftlint:enable colon comma
private extension Denomination {
    init(_ exponent: Int, _ name: String = #function, s symbol: String) {
        do {
            try self.init(exponent: exponent, name: name, symbol: symbol)
        } catch {
            incorrectImplementationShouldAlwaysBeAble(to: "Create preset denomination", error)
        }
    }
}

// MARK: CustomStringConvertible
public extension Denomination {
    var description: String {
        return name
    }
}

// MARK: - Conversion
public extension Denomination {

    static func convertMagnitude<Magnitude>(
        _ magnitude: Magnitude,
        from: Denomination,
        to: Denomination
    ) throws -> Magnitude where Magnitude: ExponentiatableInteger {

        let exponentDelta = abs(to.exponent - from.exponent)
        let factor = Magnitude(10).power(exponentDelta)

        if from == to {
            return magnitude
        } else if from > to {
            return magnitude * factor
        } else if from < to {
            let (quotient, remainder) = magnitude.quotientAndRemainder(dividingBy: factor)
            guard remainder == 0 else {
                throw Error.amountNotRepresentableAsIntegerInDenomination(
                    amount: BigUInt(magnitude),
                    fromDenomination: from,
                    toDenomination: to
                )
            }

            return quotient
        } else { incorrectImplementation("All cases should have been handled already.") }
    }

}

public extension Denomination {
    static func exponent(
        of exponent: Int,
        nameIfUnknown: String = "unknown",
        symbolIfUnknown: String = "?",
        ifUnknown: (Int, String, String) throws -> Denomination = { newExponent, newName, newSymbol in
        try Denomination(exponent: newExponent, name: newName, symbol: newSymbol)
        }
    ) rethrows -> Denomination {
        if let preset = Denomination.allCases.first(where: { $0.exponent == exponent }) {
            return preset
        }
        return try ifUnknown(exponent, nameIfUnknown, symbolIfUnknown)
    }
}
