# UnsignedInteger synthesized by proxy

Using a minimalistic generic wrapper type named  `BoundUnsignedInteger`, accepting a wrapped `UnsignedInteger` type. 

You can also limit your number type to a certain value bound. Like this:

```swift
public typealias UInt256 = BoundUnsignedInteger<UInt256Bound>
```

Where `UInt256Bound` is a super simple type defining the bounds of a `UInt256` number, like this:

```swift
import BigInt /* attaswift/BigInt */

public struct UInt256Bound: Bound {}

public extension UInt256Bound{
    typealias Value = BigUInt
    static var maxValue: Value { BigUInt(2).power(256) - 1 }
    static var minValue: Value { BigUInt.zero }
}

```
