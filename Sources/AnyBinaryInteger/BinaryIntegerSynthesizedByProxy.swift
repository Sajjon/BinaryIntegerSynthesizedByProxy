import Foundation

public protocol BinaryIntegerSynthesizedByProxy:
    BinaryInteger
where
    Words == Magnitude.Words,
    MagnitudeChecker.Value == Magnitude
{
    associatedtype MagnitudeChecker: ValueChecker
    init(check value: Magnitude) throws
}

public extension BinaryIntegerSynthesizedByProxy {
    /// Crashing init
    init(magnitude: Magnitude) {
        do {
            try self.init(check: magnitude)
        } catch {
            badLiteralValue(magnitude, error: error)
        }
    }
}

public extension BinaryIntegerSynthesizedByProxy {
    var words: Words { magnitude.words }

    static var isSigned: Bool { Magnitude.isSigned }

    var bitWidth: Int { magnitude.bitWidth }

    var trailingZeroBitCount: Int { magnitude.trailingZeroBitCount }
}

private extension BinaryIntegerSynthesizedByProxy {

    static func forward(
        _ lhs: Self, _ rhs: Self,
        _ combine: @escaping (Magnitude, Magnitude) -> Magnitude
    ) -> Self {
        let combinedMagnitude: Magnitude = forwardMagnitude(lhs, rhs, combine)
        return Self(magnitude: combinedMagnitude)
    }

    static func forwardMagnitude<Result>(
        _ lhs: Self, _ rhs: Self,
        _ combine: @escaping (Magnitude, Magnitude) -> Result
    ) -> Result {
        return forwardMapCombine(lhs, rhs, mapper: { $0.magnitude }, combine: combine)
    }

    static func forwardMapCombine<Result, Value>(
        _ lhs: Self, _ rhs: Self,
        mapper: (Self) -> Value,
        combine: (Value, Value) -> Result
    ) -> Result {
        return combine(mapper(lhs), mapper(rhs))
    }

}

// MARK: - Equatable
public extension BinaryIntegerSynthesizedByProxy {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return forwardMagnitude(lhs, rhs, ==)
    }
}

// MARK: - AdditiveArithmetic
public extension BinaryIntegerSynthesizedByProxy {

    /// The zero value.
    static var zero: Self { .init(magnitude: .zero) }

    /// Adds two values and produces their sum.
    static func + (_ lhs: Self, _ rhs: Self) -> Self {
        forward(lhs, rhs, +)
    }

    /// Adds two values and stores the result in the left-hand-side variable.
    static func += (_ lhs: inout Self, _ rhs: Self) {
        lhs = (lhs + rhs)
    }

    /// Subtracts one value from another and produces their difference.
    static func - (_ lhs: Self, _ rhs: Self) -> Self {
        forward(lhs, rhs, -)
    }

    /// Subtracts the second value from the first and stores the difference in the left-hand-side variable.
    static func -= (_ lhs: inout Self, _ rhs: Self) {
        lhs = (lhs - rhs)
    }
}

// MARK: - ExpressibleByIntegerLiteral
public extension BinaryIntegerSynthesizedByProxy {
    init(integerLiteral value: Magnitude.IntegerLiteralType) {
        self.init(magnitude: Magnitude(integerLiteral: value))
    }
}

// MARK: - Numeric
public extension BinaryIntegerSynthesizedByProxy {
    init?<T>(exactly source: T) where T : BinaryInteger {
        guard let magnitude = Magnitude(exactly: source) else { return nil }
        self.init(magnitude: magnitude)
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        forward(lhs, rhs, *)
    }

    static func *= (lhs: inout Self, rhs: Self) {
        lhs = (lhs * rhs)
    }
}

// MARK: - BinaryInteger

// MARK: BinaryInteger Arithemtic

public extension BinaryIntegerSynthesizedByProxy {


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
        let tildeMagnitude: Magnitude = ~x.magnitude
//        do {
//            return try self.init(magnitude: tildeMagnitude)
            return self.init(magnitude: tildeMagnitude)
//        } catch {
//            incorrectImplementationShouldAlwaysBeAble(to: "Error performing `~`, error: \(error)")
//        }
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

public extension BinaryIntegerSynthesizedByProxy {
    init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        let magnitude = Magnitude(truncatingIfNeeded: source)
        self.init(magnitude: magnitude)
//        if magnitude > Bound.greatestFiniteMagnitude {
//            self.magnitude = Bound.greatestFiniteMagnitude
//        } else if magnitude < Bound.leastNormalMagnitude {
//            self.magnitude = Bound.leastNormalMagnitude
//        } else {
//            self.magnitude = magnitude
//        }
    }

    init?<T>(exactly source: T) where T: BinaryFloatingPoint {
        guard let magnitude = Magnitude(exactly: source) else { return nil }
        try? self.init(magnitude: magnitude)
    }

    /// Creates the least possible amount
    init() {
        self.init(magnitude: Magnitude.zero)
//        self.magnitude = Magnitude.zero
    }

    init<T>(_ source: T) where T: BinaryInteger {
        let magnitude = Magnitude(source)
        do {
            try self.init(magnitude: magnitude)
        } catch {
            badLiteralValue(source, error: error)
        }
    }

    init<T>(_ source: T) where T: BinaryFloatingPoint {
        let magnitude = Magnitude(source)
        do {
            try self.init(magnitude: magnitude)
        } catch {
            badLiteralValue(source, error: error)
        }
    }

    init<T>(clamping source: T) where T: BinaryInteger {
        let magnitude = Magnitude(clamping: source)
//        if magnitude > Bound.greatestFiniteMagnitude {
//            self.magnitude = Bound.greatestFiniteMagnitude
//        } else if magnitude < Bound.leastNormalMagnitude {
//            self.magnitude = Bound.leastNormalMagnitude
//        } else {
//            self.magnitude = magnitude
//        }
        self.init(magnitude: magnitude)
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
private extension BinaryIntegerSynthesizedByProxy {

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
        return Self(magnitude: result)
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
public extension BinaryIntegerSynthesizedByProxy {
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
