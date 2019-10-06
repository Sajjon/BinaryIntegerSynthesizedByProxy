//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import DelTal
import BigInt /* attaswift/BigInt */

public struct Positive256Bound: Bound {}
public extension Positive256Bound{
    typealias Value = BigUInt
    static var maxValue: Value { UInt256Bound.maxValue }
    static var minValue: Value { 1 }
}

