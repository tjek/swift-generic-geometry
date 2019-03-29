# 📐 Generic Geometry

[![Swift 5](https://img.shields.io/badge/swift-5-ED523F.svg?style=flat)](https://swift.org/download/)
[![Build Status](https://travis-ci.com/shopgun/swift-generic-geometry.svg?branch=master)](https://travis-ci.com/shopgun/swift-generic-geometry)
[![Cocoapods](https://img.shields.io/cocoapods/v/shopgun-genericgeometry.svg)](http://cocoapods.org/pods/ShopGun-GenericGeometry)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE.md)

Did you ever need to make a CGSize that didn't contain CGFloats? What about a Point of enum values? Edges where some values are optional? 

All this, and more, is possible with `Generic Geometry`.

Includes the following types:

- `Point<Value>`
- `Size<Value>`
- `Rect<Value>`
- `Edges<Value>`
- `Corners<Value>`


This allows you to do things like:

```swift
let maybeSize: Size<Int?> = Size(width: nil, height: 15)
// w: nil, h: Optional(15)

let concreteSize: Size<Int> = maybeSize.unwrapped(or: Size(999))
// w: 999, h: 15

let stringSize: Size<String> = concreteSize.map(String.init)
// w: "999", h: "15"

let scaledSize = concreteSize.multipling(by: Size<Int>(width: 10, height: 100))
// w: 9990, h: 1500

let tuplePoint: Point<(Bool, Int)> = boolPoint.zip(Point<Int>(5))
// x:(true, 5), y:(false, 5)

let mappedPoint: Point<Double> = tuplePoint.map { $0 ? Double($1) * 2 : Double($1) / 2 }
// x:10.0, y:2.5
```

## Types

### Point\<Value\>

An x/y point in a 2d coordinate system.

- `init(x: Value, y: Value)` / `init(Value)`
- `zero`
- `map` / `zip` / `zipWith`
- `==` (when `Value: Equatable`)
- `init(cgPoint: CGPoint)` / `cgPoint` / `withCGFloats`


### Size\<Value\>

A width and height pair, representing a size in a 2d coordinate system.

- `init(width: Value, height: Value)` / `init(Value)`
- `zero`
- `map` / `zip` / `zipWith`
- `==` (when `Value: Equatable`)
- `multipling(by: Value)` / `multipling(by: Size<Value>)`
- `adding(Value)` / `adding(Size<Value>)`
- `dividing(by: Value)` / `dividing(by: Size<Value>)`
- `inset(Edges<Value>)` / `outset(Edges<Value>)`
- `clamped(min: Size<Value>, max: Size<Value>)`
- `unwrapped(or: Size<A>)` (when `Value == Optional<A>`)
- `init(cgSize: CGSize)` / `cgSize` / `withCGFloats`


### Rect\<Value\>

A combination of a Point and a Size, representing a rectangle in a 2d coordinate system. `origin` & `size` use the same underlying Value type.

- `init(origin: Point<Value>, size: Size<Value>)` / `init(x: Value, y: Value, width: Value, height: Value)`
- `zero`
- `map` / `zip` / `zipWith`
- `==` (when `Value: Equatable`)
- `cornerPoints: Corners<Point<Value>>`
- `inset(by: Edges<Value>)` / `inset(by: Value)`
- `outset(by: Edges<Value>)` / `outset(by: Value)`
- `init(cgRect: CGRect)` / `cgRect` / `withCGFloats`
 

### Edges\<Value\>

Contains values for the 4 edges of a rectange.

- `init(top: Value, left: Value, bottom: Value, right: Value)` / `init(Value)`
- `zero`
- `map` / `zip` / `zipWith`
- `==` / `isUniform` (when `Value: Equatable`)
- `negated`
- `adding(Value)` / `adding(Edges)`
- `cgRectEdges: [CGRectEdge: Value]` / `value(forEdge: CGRectEdge)` / `withCGFloats`
- `uiEdgeInsets`
 

### Corners\<Value\>

Contains values for the 4 corners of a rectange.

- `init(topLeft: Value, topRight: Value, bottomLeft: Value, bottomRight: Value)` / `init(Value)`
- `zero`
- `map` / `zip` / `zipWith`
- `==` / `isUniform` (when `Value: Equatable`)
- `withCGFloats`
