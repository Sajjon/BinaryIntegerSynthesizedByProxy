//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

internal func incorrectImplementationShouldAlwaysBeAble(
    to reason: String,
    _ error: Swift.Error? = nil,
    _ file: String = #file,
    _ line: Int = #line
) -> Never {
    let errorString = error.map { ", error: \($0) " } ?? ""
    incorrectImplementation("Should always be to: \(reason)\(errorString)")
}

internal func incorrectImplementation(
    _ reason: String? = nil,
    _ file: String = #file,
    _ line: Int = #line
) -> Never {
    let reasonString = reason != nil ? "`\(reason!)`" : ""
    let message = "Incorrect implementation: \(reasonString),\nIn file: \(file), line: \(line)"
    fatalError(message)
}

internal func badLiteralValue<Value>(
    _ value: Value,
    error: Swift.Error,
    _ file: String = #file,
    _ line: Int = #line
) -> Never {
    let message = "Passed bad literal value: `\(value)` to non-throwing ExpressibleByFoobarLiteral initializer, resulting in error: `\(error)`, in file: \(file), line: \(line)"
    fatalError(message)
}

internal var boundDoesNotIncludeZero: Never {
    fatalError("Bound does not include zero.")
}
