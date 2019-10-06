//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation
import DelTal
import BigInt

public typealias Kelvin = BUNCInt<NoBound<BigUInt>, KelvinName, Temperatur>

public struct KelvinName: IntegerName {
    public static let nameOfInteger = "Kelvin"
}

public struct Temperatur: IntegerCategory {
    public static let nameOfCategory = "Temperature"
}

public extension Kelvin {
    enum Water {}
}

/* Verbose (needed) syntax for: `extension Kelvin.Water` */
public extension BUNCInt.Water where Name == KelvinName, Category == Temperatur {
    static var meltsAt: Kelvin { .init(magnitude: 273) }
    static var boilsAt: Kelvin { meltsAt + 100 }
}
