//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public enum ValueError<Value: Comparable>: Swift.Error, Equatable {
    case valueTooBig(expectedAtMost: Value, butGot: Value)
    case valueTooSmall(expectedAtLeast: Value, butGot: Value)
}
