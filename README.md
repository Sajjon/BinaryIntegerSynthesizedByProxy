# DelTal

Conform to [Swift protocol `UnsignedInteger`](https://developer.apple.com/documentation/swift/unsignedinteger) by proxy with the option of adding bounds using a `typealias`.

This way you can follow [Object Callestnics's](https://williamdurand.fr/2013/06/03/object-calisthenics/)(making you a better programmer!) [third rule 'Wrap All Primitives And Strings'](https://williamdurand.fr/2013/06/03/object-calisthenics/#3-wrap-all-primitives-and-strings) for your number types in the most convenient way. While still having the power of Swift's `UnsignedInteger` (and thus `BinaryInteger`) protocol, making your code both type safe, easy to read and convenient to use.

# Example

Imagine you want to define a `UInt256` and a `UInt512` and a `UInt4096` or what ever. Using excellent [attaswift/BigInt ](https://github.com/attaswift/BigInt) we have a `BigInt` type. Using that and this Swift package, we can easily create those types **and let them automagically conform to `UnsignedInteger` protocol**.

Simplest example is using the `AnyUnsignedInteger` `typealias`, like this:
```swift
typealias BigNumber = AnyUnsignedInteger<BigUInt>
```

Where AnySig is just a typealias it self, for:
```swift
typealias AnyUnsignedInteger<Value> = BUNCInt<
    NoBound<Value>,
    AnyUnsignedIntegerName,
    InfiniteInteger
> where Value: BinaryInteger, Value.Magnitude == Value

struct InfiniteInteger: IntegerCategory {
    public static let nameOfCategory = "Infinite Integer"
}

struct AnyUnsignedIntegerName: IntegerName {
    public static let nameOfInteger = "AnyUnsignedInteger"
}

```

Where `BUNCInt` is this generic struct:

```swift
struct BUNCInt<MagnitudeChecker, Name, Category>`
```

_BUNCInt_ is short _**Bound** **U**nsigned **N**amed **C**ategorized Integer_ for which conforms to the protocol `UnsignedIntegerSynthesizedByProxy`, which provides the default implementation of the `UnsignedInteger` methods/properites/inits.

But in this example it is not at all clear why we would want to use `AnyUnsignedInteger<BigUInt>` instead of `BigUInt` right away. So let's look at some more examples.

### `UInt256` by a `typealias`

And then:
```swift
typealias UInt256 = BUNCInt<UInt256Bound, UInt256Name, NoCategory>

```

The cool part is that our `UInt256` now conforms to `UnsignedInteger` itself. So we can do arithmetic with the type.

### `UInt256Bound`

```swift
import BigInt /* attaswift/BigInt */

struct UInt256Bound: Bound {}
extension UInt256Bound{
    typealias Value = BigUInt
    static var maxValue: Value { BigUInt(2).power(256) - 1 }
    static var minValue: Value { BigUInt.zero }
}
```

### `Positive256`

In math, a positive number cannot be zero. Let's say we want to have a `UInt256` that never can be zero, then let's create it using the one line `typealias`:

```swift
typealias Positive256 = BUNCInt<Positive256Bound, Positive256Name, NoCategory>
```

Where `Positive256Bound` is similar to `UInt256Bound`, but does not allow for zeros:

```swift
import BigInt /* attaswift/BigInt */

struct Positive256Bound: Bound {}
extension Positive256Bound{
    typealias Value = BigUInt
    static var maxValue: Value { UInt256Bound.maxValue }
    static var minValue: Value { 1 }
}
```


## Name & Category

Let's say we want a `Kelvin` temperature integer (we only deal with integers in this Swift Package). `Kelvin` it can go from `0` to `infinity` (that's pretty hot 🔥), thus it is an onbound. 

But let's say we want to add some `static` preset values of `Kelvin`. If `BUNCInt` did not take a `Name` and `Category` as a generic, we would not have been able to only add `static` preset values to **only** the type `Kelvin`. But since we have generic `Name` and `Category` we can do exactly that.

```swift
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
```

Now we can use the `Kelvin` type like this:
```swift
    func testMeltTemperatur() {
        XCTAssertEqual(Kelvin.Water.meltsAt, 273)
        XCTAssertEqual(
            Kelvin.Water.boilsAt - Kelvin.Water.meltsAt, 
            100
        )
    }
```

Another advantage of the generic `Name` and `Category` of `BUNCInt` is that we get context to our values, which we are using conforming to `CustomStringConvertible` and `CustomDebugStringConvertible`, resulting in this.

```swift
    func testKelvinDescription() {
        XCTAssertEqual(
            Kelvin.Water.boilsAt.description, 
            "373 Kelvin"
        )

        XCTAssertEqual(
            Kelvin.Water.boilsAt.debugDescription,
            "373 Kelvin (Temperature)"
        )
    }
```

# Installation

### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/Sajjon/DelTal.git", from: "0.0.1")
]
```

# Etymology 🇸🇪
_"DelTal"_ is a play with Swedish words. The English word _"Integer"_ is _"Heltal"_ in Swedish. Replacing `Hel` with `Del`, where _"Del"_ is short for _"Delegerat"_, meaning _"Delegated"_ in English. 

In other words, "a delegated integer", but as a Swedish pun.
