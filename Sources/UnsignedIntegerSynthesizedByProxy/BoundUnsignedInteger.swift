//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-05.
//

import Foundation

public struct BoundUnsignedInteger<MagnitudeChecker>:
    UnsignedIntegerSynthesizedByProxy where
    MagnitudeChecker: ValueChecker,
    MagnitudeChecker.Value: BinaryInteger,
    MagnitudeChecker.Value.Magnitude == MagnitudeChecker.Value
{

    public typealias Magnitude = MagnitudeChecker.Value

    public let magnitude: Magnitude
    public init(check value: Magnitude) throws {
        magnitude = try MagnitudeChecker.withinBound(value: value).validated
    }

}

public extension BoundUnsignedInteger {
    typealias IntegerLiteralType = Magnitude.IntegerLiteralType

    typealias Words = Magnitude.Words
}
