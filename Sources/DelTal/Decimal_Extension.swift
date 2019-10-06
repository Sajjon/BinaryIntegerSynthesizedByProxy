//
//  File.swift
//
//
//  Created by Alexander Cyon on 2019-10-06.
//
import Foundation

public extension Decimal {
    enum Error: Int, Swift.Error, Equatable {
        case divideByZero, lossOfPrecision, overflow, underflow, unknown
    }
}

public extension Decimal.Error {
    init?(exception: NSDecimalNumber.CalculationError) {
        switch exception {
        case .noError: return nil
        case .divideByZero: self = .divideByZero
        case .lossOfPrecision: self = .lossOfPrecision
        case .overflow: self = .overflow
        case .underflow: self = .underflow
        @unknown default: self = .unknown
        }
    }
}

internal extension NumberFormatter {
    static var `default`: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        formatter.locale = Locale.current
        return formatter
    }
}

public extension Decimal {
    
    static func ten(
        toThePowerOf exponent: Int,
        roundingMode: NSDecimalNumber.RoundingMode = .plain
    ) throws -> Decimal {
        
        return try pow(base: 10, exponent: exponent, roundingMode: roundingMode)
    }
    
    static func pow(
        base: Decimal,
        exponent: Int,
        roundingMode: NSDecimalNumber.RoundingMode = .plain
    ) throws -> Decimal {
        
        if exponent == 0 { return Decimal(1) }
        if exponent == 1 { return base }
        
        var result = Decimal()
        var base = base
        
        let exception = NSDecimalPower(&result, &base, abs(exponent), roundingMode)
        
        if let error = Error(exception: exception) {
            throw error
        }
        
        if exponent > 1 {
            return result
        } else if exponent < 0 {
            return try Self.divide(nominator: 1, denominator: result)
        } else { incorrectImplementation("Base case where exponent=\(exponent) should have been earlier.") }
    }
    
    static func divide(
        nominator: Decimal,
        denominator: Decimal,
        roundingMode: NSDecimalNumber.RoundingMode = .plain
    ) throws -> Decimal {
        
        return try doOperation(lhs: nominator, rhs: denominator, roundingMode: roundingMode, NSDecimalDivide)
    }
}

private extension Decimal {
    
    static func doOperation(
        lhs: Decimal,
        rhs: Decimal,
        roundingMode: NSDecimalNumber.RoundingMode = .plain,
        _ operation: (UnsafeMutablePointer<Decimal>, UnsafePointer<Decimal>, UnsafePointer<Decimal>, NSDecimalNumber.RoundingMode) -> NSDecimalNumber.CalculationError,
        _ resultHandler: (Decimal) -> Decimal = { $0 }
    ) throws -> Decimal {
        
        var result = Decimal()
        var lhs = lhs
        var rhs = rhs
        
        let exception = operation(&result, &lhs, &rhs, roundingMode)
        
        if let error = Error(exception: exception) {
            throw error
        }
        
        return resultHandler(result)
    }
}
