//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public typealias AnyUnsignedInteger<Value> = BUNCInt<
    NoBound<Value>,
    AnyUnsignedIntegerName,
    InfiniteInteger
> where Value: BinaryInteger, Value.Magnitude == Value

public struct InfiniteInteger: IntegerCategory {
    public static let nameOfCategory = "Infinite Integer"
}

public struct AnyUnsignedIntegerName: IntegerName {
    public static let nameOfInteger = "AnyUnsignedInteger"
}
