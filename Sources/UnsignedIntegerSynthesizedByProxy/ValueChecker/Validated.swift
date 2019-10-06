//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

public struct Validated<Value> where Value: Validatable {
    public let validated: Value
}
