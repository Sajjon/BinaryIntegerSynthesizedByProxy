//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-05.
//

import Foundation
import BigInt

public protocol BinaryIntegerByProxy:
    BinaryInteger
where
    IntegerLiteralType == Magnitude.IntegerLiteralType
{
    var proxy: Proxy { get }
    init(proxy: Proxy)
}

public extension BinaryIntegerByProxy {
    typealias Proxy = AnyBinaryInteger<Magnitude>
    var magnitude: Magnitude { proxy.magnitude }
}

// MARK: - Equatable
public extension BinaryIntegerByProxy {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.proxy == rhs.proxy
    }
}

// MARK: - AdditiveArithmetic
public extension BinaryIntegerByProxy {

    /// The zero value.
    static var zero: Self { .init(proxy: Proxy.zero) }

    /// Adds two values and produces their sum.
    static func + (_ lhs: Self, _ rhs: Self) -> Self { .init(proxy: lhs.proxy + rhs.proxy) }

    /// Adds two values and stores the result in the left-hand-side variable.
    static func += (_ lhs: inout Self, _ rhs: Self) {
        lhs = (lhs + rhs)
    }

    /// Subtracts one value from another and produces their difference.
    static func - (_ lhs: Self, _ rhs: Self) -> Self { .init(proxy: lhs.proxy - rhs.proxy) }

    /// Subtracts the second value from the first and stores the difference in the left-hand-side variable.
    static func -= (_ lhs: inout Self, _ rhs: Self) {
        lhs = (lhs - rhs)
    }
}

// MARK: - Numeric
public extension BinaryIntegerByProxy {

    static var isSigned: Bool { Proxy.isSigned }

    var bitWidth: Int { proxy.bitWidth }

    var trailingZeroBitCount: Int { proxy.trailingZeroBitCount }

    var words: Magnitude.Words { proxy.words }

    init?<T>(exactly source: T) where T : BinaryInteger {
        fatalError("not supported")
    }

    static func * (lhs: Self, rhs: Self) -> Self { .init(proxy: lhs.proxy * rhs.proxy) }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs = (lhs * rhs)
    }

}

// MARK: - ExpressibleByIntegerLiteral
public extension BinaryIntegerByProxy {
    init(integerLiteral value: IntegerLiteralType) {
        fatalError("not supported")
    }
}

// MARK: - Hashable
public extension BinaryIntegerByProxy {
    func hash(into hasher: inout Hasher) {
        hasher.combine(magnitude)
    }
}

// MARK: - BinaryInteger

// MARK: BinaryInteger Arithemtic

public extension BinaryIntegerByProxy {


    static func / (lhs: Self, rhs: Self) -> Self {
        return calculateOrCrash(lhs, rhs, /)
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    static func % (lhs: Self, rhs: Self) -> Self {
        return calculateOrCrash(lhs, rhs, %)
    }

    static func %= (lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }

    static func & (lhs: Self, rhs: Self) -> Self {
        return calculateOrCrash(lhs, rhs, &)
    }

    static func &= (lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }

    static func | (lhs: Self, rhs: Self) -> Self {
        return calculateOrCrash(lhs, rhs, |)
    }

    static func |= (lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }

    static func ^ (lhs: Self, rhs: Self) -> Self {
        return calculateOrCrash(lhs, rhs, ^)
    }

    static func ^= (lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }

    prefix static func ~ (x: Self) -> Self {
//        let tildeMagnitude: Magnitude = ~x.magnitude
        whatToDo()
    }

    static func >> <RHS>(lhs: Self, rhs: RHS) -> Self where RHS: BinaryInteger {
        return calculateOrCrashOtherBinaryInteger(lhs, rhs, >>)
    }

    static func >>= <RHS>(lhs: inout Self, rhs: RHS) where RHS: BinaryInteger {
        lhs = lhs >> rhs
    }

    static func << <RHS>(lhs: Self, rhs: RHS) -> Self where RHS: BinaryInteger {
        return calculateOrCrashOtherBinaryInteger(lhs, rhs, <<)
    }

    static func <<= <RHS>(lhs: inout Self, rhs: RHS) where RHS: BinaryInteger {
        lhs = lhs << rhs
    }
}

// MARK: BinaryInteger Init

public extension BinaryIntegerByProxy {
    init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
//        let magnitude = Magnitude(truncatingIfNeeded: source)
//        self.init(magnitude: magnitude)

        whatToDo()


        //        if magnitude > Bound.greatestFiniteMagnitude {
        //            self.magnitude = Bound.greatestFiniteMagnitude
        //        } else if magnitude < Bound.leastNormalMagnitude {
        //            self.magnitude = Bound.leastNormalMagnitude
        //        } else {
        //            self.magnitude = magnitude
        //        }
    }

    init?<T>(exactly source: T) where T: BinaryFloatingPoint {
//        guard let magnitude = Magnitude(exactly: source) else { return nil }
//        try? self.init(magnitude: magnitude)
        whatToDo()

    }

    /// Creates the least possible amount
    init() {
        whatToDo()
//        self.magnitude = Magnitude.zero
    }

    init<T>(_ source: T) where T: BinaryInteger {
//        let magnitude = Magnitude(source)
//        do {
//            try self.init(magnitude: magnitude)
//        } catch {
//            badLiteralValue(source, error: error)
//        }
        whatToDo()

    }

    init<T>(_ source: T) where T: BinaryFloatingPoint {
//        let magnitude = Magnitude(source)
//        do {
//            try self.init(magnitude: magnitude)
//        } catch {
//            badLiteralValue(source, error: error)
//        }
        whatToDo()

    }

    init<T>(clamping source: T) where T: BinaryInteger {
//        let magnitude = Magnitude(clamping: source)
        //        if magnitude > Bound.greatestFiniteMagnitude {
        //            self.magnitude = Bound.greatestFiniteMagnitude
        //        } else if magnitude < Bound.leastNormalMagnitude {
        //            self.magnitude = Bound.leastNormalMagnitude
        //        } else {
        //            self.magnitude = magnitude
        //        }
//        self.init(magnitude: magnitude)
        whatToDo()

    }

    //    init(integerLiteral value: Magnitude.IntegerLiteralType) {
    //        let magnitude = Magnitude.init(integerLiteral: value)
    //        do {
    //            try self.init(magnitude: magnitude)
    //        } catch {
    //            badLiteralValue(value, error: error)
    //        }
    //    }
}


// swiftlint:enable shorthand_operator

// MARK: - Private Helper
private extension BinaryIntegerByProxy {

    static func calculateOrCrash(_ lhs: Self, _ rhs: Self, _ function: (Self, Self) throws -> Self) -> Self {
        do {
            return try function(lhs, rhs)
        } catch {
            incorrectImplementationShouldAlwaysBeAble(to: "Perform arithmetic between (lhs: \(lhs), rhs: \(rhs)), error: \(error)")
        }
    }

    static func calculateOrCrashOtherBinaryInteger<RHS>(_ lhs: Self, _ rhs: RHS, _ function: (Self, RHS) throws -> Self) -> Self where RHS: BinaryInteger {
        do {
            return try function(lhs, rhs)
        } catch {
            incorrectImplementationShouldAlwaysBeAble(to: "Perform arithmetic between (lhs: \(lhs), rhs: \(rhs)), error: \(error)")
        }
    }

    static func calculate(
        _ lhs: Self,
        _ rhs: Self,
        willOverflowIf overflowCheck: @autoclosure () -> Bool = { false }(),
        operation: @escaping (Magnitude, Magnitude) -> Magnitude
    ) throws -> Self {
        precondition(overflowCheck() == false, "Overflow")
        let result = try calculateMagnitude(lhs.magnitude, rhs.magnitude, operation: operation)
        //        return try Self(magnitude: result)
//        return Self(magnitude: result)
        whatToDo()

    }

    static func calculateMagnitude(
        _ lhs: Magnitude,
        _ rhs: Magnitude,
        willOverflowIf overflowCheck: @autoclosure () -> Bool = { false }(),
        operation: (Magnitude, Magnitude) -> Magnitude
    ) throws -> Magnitude {
        precondition(overflowCheck() == false, "Overflow")
        let result = operation(lhs, rhs)
        //        try Bound.contains(value: result)
        return result
    }

}

// MARK: - Comparable
public extension BinaryIntegerByProxy {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.magnitude < rhs.magnitude
    }

    static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.magnitude > rhs.magnitude
    }

    //    static func == (lhs: Self, rhs: Self) -> Bool {
    //        return lhs.magnitude == rhs.magnitude
    //    }
}

func whatToDo() -> Never { fatalError("What to do?") }
var placeholder: Never { fatalError("Placeholder") }
