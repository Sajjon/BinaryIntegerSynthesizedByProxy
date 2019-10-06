//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import DelTal

public typealias Positive256 = BUNCInt<Positive256Bound, Positive256Name, NoCategory>

public struct Positive256Name: IntegerName {
    public static let nameOfInteger = "Positive256"
}
