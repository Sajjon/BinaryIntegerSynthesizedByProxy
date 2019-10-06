//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import BigInt /* attaswift/BigInt */

public struct UInt256Bound: Bound {}
public extension UInt256Bound{
    typealias Value = BigUInt
    static var maxValue: Value { BigUInt(2).power(256) - 1 }
    static var minValue: Value { BigUInt.zero }
}

