//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public struct NoBound<Value>: ValueChecker where Value: Validatable {

    public static func withinBound(value: Value) throws -> Validated<Value> {
        return Validated(validated: value)
    }
}
