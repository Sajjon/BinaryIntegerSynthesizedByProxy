//
//  File.swift
//
//
//  Created by Alexander Cyon on 2019-10-06.
//

import Foundation

extension Denomination: CaseIterable {}
public extension Denomination {
    static var allCases: [Denomination] {
        return
            allDenominationsWithNegativeExponent +
                [Denomination.whole] +
        allDenominationsWithPositiveExponent
    }
    
    static var allDenominationsWithPositiveExponent: [Denomination] {
        return [.deca, .hecto, .kilo, .mega, .giga, .tera, .peta, .exa]
    }
    
    static var allDenominationsWithNegativeExponent: [Denomination] {
        return [.atto, .femto, .pico, .nano, .micro, .milli, .centi, .deci]
    }
}
