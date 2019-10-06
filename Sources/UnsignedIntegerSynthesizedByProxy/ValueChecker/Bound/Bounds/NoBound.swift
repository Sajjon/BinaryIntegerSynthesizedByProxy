//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public struct NoBound<Value>: Bound where Value: Validatable {
    public static var maxValue: Value? { nil }
    public static var minValue: Value? { nil }
}
