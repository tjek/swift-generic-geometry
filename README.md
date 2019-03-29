# 📐 Generic Geometry

[![Swift 5](https://img.shields.io/badge/swift-5-ED523F.svg?style=flat)](https://swift.org/download/)
[![Build Status](https://travis-ci.com/shopgun/swift-generic-geometry.svg?branch=master)](https://travis-ci.com/shopgun/swift-generic-geometry)
[![Cocoapods](https://img.shields.io/cocoapods/v/shopgun-genericgeometry.svg)](http://cocoapods.org/pods/ShopGun-GenericGeometry)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](LICENSE.md)

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
// w: nil, h: Optional(15)

let concreteSize: Size<Int> = maybeSize.unwrapped(or: Size(999))
// w: 999, h: 15

let stringSize: Size<String> = concreteSize.map(String.init)
// w: "999", h: "15"

let scaledSize = concreteSize.multipling(by: Size<Int>(width: 10, height: 100))
// w: 9990, h: 1500

```