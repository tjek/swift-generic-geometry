# 📐 Generic Geometry

A library for defining geometry of arbitrary, generic dimensions.

Includes the following types:

- `Point<Value>`
- `Size<Value>`
- `Rect<Value>`
- `Edges<Value>`
- `Corners<Value>`


This allows you to do things like:

```swift
let maybeSize: Size<Int?> = Size(width: nil, height: 15)
// w: nil, h: 15

let concreteSize: Size<Int> = maybeSize.unwrapped(or: Size(999))
// w: 999, h: 15

let stringSize: Size<String> = concreteSize.map(String.init)
// w: "999", h: "15"

let scaledSize = concreteSize.multipling(by: Size<Int>(width: 10, height: 100))
// w: 9990, h: 1500

```