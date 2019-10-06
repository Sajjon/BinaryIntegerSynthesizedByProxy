//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import BigInt

public struct UInt256Bound: Bound {
    public typealias Value = BigUInt
    public static var maxValue: Value? { BigUInt(2).power(256) - 1 }
    public static var minValue: Value? { BigUInt.zero }
}

