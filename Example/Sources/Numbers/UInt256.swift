//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import DelTal

public typealias UInt256 = BUNCInt<UInt256Bound, UInt256Name, NoCategory>

public struct UInt256Name: IntegerName {
    public static let nameOfInteger = "UInt256"
}

public struct NoCategory: IntegerCategory {
    public static let nameOfCategory = "Uncategorized"
}
