import BigInt

public struct AnyNumeric<Magnitude>: Numeric where Magnitude: BinaryInteger {

    public let magnitude: Magnitude

    public init(magnitude: Magnitude) {
        self.magnitude = magnitude
    }
}

private extension AnyNumeric {

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
public extension AnyNumeric {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return forwardMagnitude(lhs, rhs, ==)
    }
}

// MARK: - AdditiveArithmetic
public extension AnyNumeric {

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
public extension AnyNumeric {
    init(integerLiteral value: Magnitude.IntegerLiteralType) {
        self.init(magnitude: Magnitude(integerLiteral: value))
    }
}

// MARK: - Numeric
public extension AnyNumeric {
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
