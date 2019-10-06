//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public protocol Bound: ValueChecker {
    static var maxValue: Value? { get }
    static var minValue: Value? { get }
}

public extension Bound {

    static func withinBound(value: Value) throws -> Validated<Value> {
        if let maxValue = maxValue, value > maxValue {
            throw ValueError<Value>.valueTooBig(
                expectedAtMost: maxValue,
                butGot: value
            )
        }

        if let minValue = minValue, value < minValue {
            throw ValueError<Value>.valueTooSmall(
                expectedAtLeast: minValue,
                butGot: value
            )
        }

        // All good
        return Validated(validated: value)
    }
}
