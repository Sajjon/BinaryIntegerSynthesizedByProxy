import Foundation

public protocol UnsignedIntegerSynthesizedByProxy:
    UnsignedInteger
where
    Words == Magnitude.Words,
    MagnitudeChecker.Value == Magnitude
{
    associatedtype MagnitudeChecker: ValueChecker
    var magnitude: Magnitude { get }
    init(check value: Magnitude) throws
}

public extension UnsignedIntegerSynthesizedByProxy {
    /// Crashing init
    init(magnitude: Magnitude) {
        do {
            try self.init(check: magnitude)
        } catch {
            badLiteralValue(magnitude, error: error)
        }
    }
}

public extension UnsignedIntegerSynthesizedByProxy {
    var words: Words { magnitude.words }

    static var isSigned: Bool { Magnitude.isSigned }

    var bitWidth: Int { magnitude.bitWidth }

    var trailingZeroBitCount: Int { magnitude.trailingZeroBitCount }
}


// MARK: - Equatable
public extension UnsignedIntegerSynthesizedByProxy {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return forwardMagnitude(lhs, rhs, ==)
    }
}

// MARK: - Comparable
public extension UnsignedIntegerSynthesizedByProxy {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return forwardMagnitude(lhs, rhs, <)
    }

    static func > (lhs: Self, rhs: Self) -> Bool {
        return forwardMagnitude(lhs, rhs, >)
    }
}


// MARK: - AdditiveArithmetic
public extension UnsignedIntegerSynthesizedByProxy {

    /// The zero value.
    static var zero: Self { .init(magnitude: .zero) }

    /// The minimum representable integer in this type.
    static var min: Self { .zero }

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
public extension UnsignedIntegerSynthesizedByProxy {
    init(integerLiteral value: Magnitude.IntegerLiteralType) {
        self.init(magnitude: Magnitude(integerLiteral: value))
    }
}

// MARK: - Numeric
public extension UnsignedIntegerSynthesizedByProxy {
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

public extension UnsignedIntegerSynthesizedByProxy {


    static func / (lhs: Self, rhs: Self) -> Self {
        return forward(lhs, rhs, /)
    }

    static func /= (lhs: inout Self, rhs: Self) {
        lhs = lhs / rhs
    }

    static func % (lhs: Self, rhs: Self) -> Self {
        return forward(lhs, rhs, %)
    }

    static func %= (lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }

    static func & (lhs: Self, rhs: Self) -> Self {
        return forward(lhs, rhs, &)
    }

    static func &= (lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }

    static func | (lhs: Self, rhs: Self) -> Self {
        return forward(lhs, rhs, |)
    }

    static func |= (lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }

    static func ^ (lhs: Self, rhs: Self) -> Self {
        return forward(lhs, rhs, ^)
    }

    static func ^= (lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }

    prefix static func ~ (x: Self) -> Self {
        let tildeMagnitude: Magnitude = ~x.magnitude
        return self.init(magnitude: tildeMagnitude)
    }

    static func >> <RHS>(lhs: Self, rhs: RHS) -> Self where RHS: BinaryInteger {
        return calculateOrCrashOtherInteger(lhs, rhs, >>)
    }

    static func >>= <RHS>(lhs: inout Self, rhs: RHS) where RHS: BinaryInteger {
        lhs = lhs >> rhs
    }

    static func << <RHS>(lhs: Self, rhs: RHS) -> Self where RHS: BinaryInteger {
        return calculateOrCrashOtherInteger(lhs, rhs, <<)
    }

    static func <<= <RHS>(lhs: inout Self, rhs: RHS) where RHS: BinaryInteger {
        lhs = lhs << rhs
    }
}

// swiftlint:enable shorthand_operator


// MARK: BinaryInteger Init
public extension UnsignedIntegerSynthesizedByProxy {

    init?<T>(exactly source: T) where T: BinaryFloatingPoint {
        guard let magnitude = Magnitude(exactly: source) else { return nil }
        try? self.init(check: magnitude)
    }

    init<T>(_ source: T) where T: BinaryInteger {
        let magnitude = Magnitude(source)
        do {
            try self.init(check: magnitude)
        } catch {
            badLiteralValue(source, error: error)
        }
    }

    init<T>(_ source: T) where T: BinaryFloatingPoint {
        let magnitude = Magnitude(source)
        do {
            try self.init(check: magnitude)
        } catch {
            badLiteralValue(source, error: error)
        }
    }
}

// MARK: BinaryInteger where Bound
public extension UnsignedIntegerSynthesizedByProxy where MagnitudeChecker: Bound {

    /// The maximum representable integer in this type.
    static var max: Self {
        .init(magnitude: Self.maxMagnitude)
    }

    /// The zero value.
    static var zero: Self { //.init(magnitude: .zero) }
        let zeroMagnitude = Magnitude.zero
        guard minMagnitude <= zeroMagnitude else {
            boundDoesNotIncludeZero
        }
        return .init(magnitude: zeroMagnitude)
    }

    /// The minimum representable integer in this type.
    static var min: Self {
        .init(magnitude: Self.minMagnitude)
    }

    static var maxMagnitude: Magnitude { MagnitudeChecker.maxValue }
    static var minMagnitude: Magnitude { MagnitudeChecker.minValue }

    init<T>(clamping source: T) where T: BinaryInteger {
        let magnitude = Magnitude(clamping: source)

        if magnitude > Self.maxMagnitude {
            self.init(magnitude: Self.maxMagnitude)
        } else if magnitude < Self.minMagnitude {
            self.init(magnitude: Self.minMagnitude)
        } else {
            self.init(magnitude: magnitude)
        }
    }

    init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        let magnitude = Magnitude(truncatingIfNeeded: source)
        if magnitude > Self.maxMagnitude {
            self.init(magnitude: Self.maxMagnitude)
        } else if magnitude < Self.minMagnitude {
            self.init(magnitude: Self.minMagnitude)
        } else {
            self.init(magnitude: magnitude)
        }
    }

    /// Creates the least possible amount
    init() {
        self.init(magnitude: Self.minMagnitude)
    }
}

// MARK: BinaryInteger not Bound
public extension UnsignedIntegerSynthesizedByProxy {
    init<T>(clamping source: T) where T: BinaryInteger {
        let magnitude = Magnitude(clamping: source)
        self.init(magnitude: magnitude)
    }

    init<T>(truncatingIfNeeded source: T) where T: BinaryInteger {
        let magnitude = Magnitude(truncatingIfNeeded: source)
        self.init(magnitude: magnitude)
    }

    /// Creates the least possible amount
    init() {
        self.init(magnitude: Magnitude.zero)
    }
}

// MARK: - Private Helpers

private extension UnsignedIntegerSynthesizedByProxy {

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

    static func calculateOrCrashOtherInteger<RHS>(_ lhs: Self, _ rhs: RHS, _ function: (Self, RHS) throws -> Self) -> Self where RHS: BinaryInteger {
        do {
            return try function(lhs, rhs)
        } catch {
            incorrectImplementationShouldAlwaysBeAble(to: "Perform arithmetic between (lhs: \(lhs), rhs: \(rhs)), error: \(error)")
        }
    }
}
