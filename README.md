# DelTal

Conform to UnsignedInteger by proxy with the option of adding bounds.


You can create a (completely meaningless) proxied `UInt32` clone called `UI32` like this:

```swift
typealias UI32 = AnyInteger<UInt32> 
// ( we will explain `NoTrait` later )
```

Where actually `AnyInteger` is a `typealias` itself:
```swift
typealias AnyInteger<Value: BinaryInteger> = BoundUnsignedInteger<NoBound<Value>, NoTrait> where Value.Magnitude == Value

// (we will explain `NoTrait` later)
```

## Example

**"Ok, so what?"**

Well imagine you want to define a `UInt256` and a `UInt512` and a `UInt4096` or what ever. Using excellent [attaswift/BigInt ](https://github.com/attaswift/BigInt) we have a `BigInt` type. Using that and this pacakge (`DelTal`), we can easily create those types **and let them automagically conform to `UnsignedInteger` protocol**.

### UInt256Bound

```swift
import BigInt /* attaswift/BigInt */

struct UInt256Bound: Bound {}
extension UInt256Bound{
    typealias Value = BigUInt
    static var maxValue: Value { BigUInt(2).power(256) - 1 }
    static var minValue: Value { BigUInt.zero }
}
```

### UInt256 by a `typealias`

And then:
```swift
typealias UInt256 = BoundUnsignedInteger<UInt256Bound, NoTrait>

```

That's it.

The cool part is that our `UInt256` now conforms to `UnsignedInteger` itself. So we can so arithmetic with it just as we want!

### `Positive256`

In math, a positive number cannot be zero. Let's say we want to have a `UInt256` that never can be zero, then let's create it using the one line `typealias`:

```swift
typealias Positive256 = BoundUnsignedInteger<Positive256Bound, NoTrait>
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


### Traits

And `IntegerTrait`:
```swift
public protocol IntegerTrait {
    static var context: String { get }
}

```

In the example of the `UInt256` above we used `NoTrait`, which  is this simple struct:

```swift
public struct NoTrait: IntegerTrait {
    public static let context = "NoTrait"
}

```

So what are these traits? We can use them for context so that we might distinguish a `BoundUnsignedInteger` from another, by using the `Trait` instead of the `Bounds`.


## Etymology 🇸🇪
_DelTal_ is a play with Swedish words. The English word _"Integer"_ is _"Heltal"_ in Swedish. Replacing `Hel` with `Del`, where `Del` is short for _"Delegerat"_, meaning `Delegated`. 

In other words, "an Integer by Proxy", but as a Swedish pun.
