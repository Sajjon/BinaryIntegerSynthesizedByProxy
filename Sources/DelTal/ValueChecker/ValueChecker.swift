//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public protocol ValueChecker {
    associatedtype Value: Validatable

    // Default `magnitudeMeasuiredInDenomination` is `whole`.
    static var magnitudeMeasuiredInDenomination: Denomination { get }

    // Default `minDenomination` is `whole`.
    static var minDenomination: Denomination { get }

    static func withinBound(value: Value) throws -> Validated<Value>
}

public extension ValueChecker {
    // Default `magnitudeMeasuiredInDenomination` is `whole`.
    static var magnitudeMeasuiredInDenomination: Denomination { .whole }

    // Default `minDenomination` is `whole`.
    static var minDenomination: Denomination { .whole }
}
