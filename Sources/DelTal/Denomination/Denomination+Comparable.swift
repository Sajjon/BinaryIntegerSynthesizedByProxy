//
//  File.swift
//
//
//  Created by Alexander Cyon on 2019-10-06.
//


import Foundation

extension Denomination: Comparable {}

public extension Denomination {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return compare(lhs, rhs, keyPath: \.exponent, ==)
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        return compare(lhs, rhs, keyPath: \.exponent, <)
    }
    
    static func > (lhs: Self, rhs: Self) -> Bool {
        return compare(lhs, rhs, keyPath: \.exponent, >)
    }
}

public extension Comparable {
    static func compare<C>(_ lhs: Self, _ rhs: Self, keyPath: KeyPath<Self, C>, _ comparison: (C, C) -> Bool) -> Bool where C: Comparable {
        let lhsValue = lhs[keyPath: keyPath]
        let rhsValue = rhs[keyPath: keyPath]
        return comparison(lhsValue, rhsValue)
    }
}
