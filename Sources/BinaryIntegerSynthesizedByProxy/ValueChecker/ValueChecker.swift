//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public protocol ValueChecker {
    associatedtype Value: Validatable

    static func withinBound(value: Value) throws -> Validated<Value>
}
