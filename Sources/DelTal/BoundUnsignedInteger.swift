//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-05.
//

import Foundation

/// `BUNCInt` is an abbreviation for `Bound Unsigned Named Categorized Integer`
public struct BUNCInt<MagnitudeChecker, Name, Category>:
    UnsignedIntegerSynthesizedByProxy,
    CustomStringConvertible,
    CustomDebugStringConvertible
where
    MagnitudeChecker: ValueChecker,
    MagnitudeChecker.Value: BinaryInteger,
    MagnitudeChecker.Value.Magnitude == MagnitudeChecker.Value,
    Name: IntegerName,
    Category: IntegerCategory
{

    public typealias Magnitude = MagnitudeChecker.Value

    public let magnitude: Magnitude
    public init(check value: Magnitude) throws {
        magnitude = try MagnitudeChecker.withinBound(value: value).validated
    }

}

public extension BUNCInt {
    typealias IntegerLiteralType = Magnitude.IntegerLiteralType

    typealias Words = Magnitude.Words
}

// MARK: - CustomStringConvertible
public extension BUNCInt {
    var description: String {
        "\(magnitude) \(Name.nameOfInteger)"
    }
}

// MARK: - CustomDebugStringConvertible
public extension BUNCInt {
    var debugDescription: String {
        "\(self.description) (\(Category.nameOfCategory))"
    }
}
