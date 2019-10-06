//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public protocol BinaryIntegerFromString {
    init?<S>(_ text: S, radix: Int) where S: StringProtocol
}

public protocol ExponentiatableInteger: BinaryInteger & BinaryIntegerFromString {
    func power(_ exponent: Int) -> Self
}

extension ExponentiatableInteger where Self: FixedWidthInteger {
    public func power(_ exponent: Int) -> Self {
        let x = self
        var result: Self = 1
        for _ in 0..<exponent {
            result *= x
        }
        return result
    }
}

extension UInt64: ExponentiatableInteger {}
extension UInt32: ExponentiatableInteger {}
extension UInt16: ExponentiatableInteger {}
extension UInt8: ExponentiatableInteger {}
extension Int64: ExponentiatableInteger {}
extension Int32: ExponentiatableInteger {}
extension Int16: ExponentiatableInteger {}
extension Int8: ExponentiatableInteger {}

import BigInt
extension BigUInt: ExponentiatableInteger {}
extension BigInt: ExponentiatableInteger {}
