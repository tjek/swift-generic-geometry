//
//  ┌────┬─┐         ┌─────┐
//  │  ──┤ └─┬───┬───┤  ┌──┼─┬─┬───┐
//  ├──  │ ╷ │ · │ · │  ╵  │ ╵ │ ╷ │
//  └────┴─┴─┴───┤ ┌─┴─────┴───┴─┴─┘
//               └─┘
//
//  Copyright (c) 2018 ShopGun. All rights reserved.

import Foundation

////////////////////////////
// MARK: - Point
////////////////////////////

/// A 2d coordinate. The type of value it contains is generic
public struct Point<Value> {
    public var x, y: Value
    
    public init(x: Value, y: Value) {
        self.x = x
        self.y = y
    }
}
public typealias PointDbl = Point<Double>

extension Point {
    /// A simple initializer allowing the Point to be created with the same x/y value.
    public init(_ val: Value) {
        self.init(x: val, y: val)
    }
}

extension Point {
    public func map<A>(_ transform: (Value) -> A) -> Point<A> {
        return Point<A>(
            x: transform(x),
            y: transform(y)
        )
    }
    public func zip<A>(_ other: Point<A>) -> Point<(Value, A)> {
        return Point<(Value, A)>(
            x: (x, other.x),
            y: (y, other.y)
        )
    }
    public func zipWith<A, B>(_ other: Point<A>, _ combine: @escaping (Value, A) -> B) -> Point<B> {
        return self.zip(other).map(combine)
    }
}

extension Point: Equatable where Value: Equatable {
    /// Make Point equatable if it's values are equatable.
    public static func == (lhs: Point<Value>, rhs: Point<Value>) -> Bool {
        return lhs.x == rhs.x
            && lhs.y == rhs.y
    }
}

extension Point where Value: Numeric {
    /// The identity of point with 0,0 x/y values
    public static var zero: Point {
        return Point(x: 0, y: 0)
    }
}

extension Point: CustomDebugStringConvertible {
    /// Print out an attractive
    public var debugDescription: String {
        return "{ x:\(x), y:\(y) }"
    }
}

////////////////////////////
// MARK: - Size
////////////////////////////

public struct Size<Value> {
    public var width, height: Value
    
    public init(width: Value, height: Value) {
        self.width = width
        self.height = height
    }
}
public typealias SizeDbl = Size<Double>

extension Size {
    public init(_ val: Value) {
        self.init(width: val, height: val)
    }
}

extension Size {
    public func map<A>(_ transform: (Value) -> A) -> Size<A> {
        return Size<A>(
            width: transform(width),
            height: transform(height)
        )
    }
    public func zip<A>(_ other: Size<A>) -> Size<(Value, A)> {
        return Size<(Value, A)>(
            width: (width, other.width),
            height: (height, other.height)
        )
    }
    public func zipWith<A, B>(_ other: Size<A>, _ combine: @escaping (Value, A) -> B) -> Size<B> {
        return self.zip(other).map(combine)
    }
}

extension Size: Equatable where Value: Equatable {
    public static func == (lhs: Size<Value>, rhs: Size<Value>) -> Bool {
        return lhs.width == rhs.width
            && lhs.height == rhs.height
    }
}

extension Size where Value: Numeric {
    public static var zero: Size {
        return Size(width: 0, height: 0)
    }
}

extension Size {
    public var optional: Size<Optional<Value>> {
        return self.map { $0 }
    }
}

extension Size where Value: Numeric {
    public func multipling(by value: Value) -> Size {
        return self.map { $0 * value }
    }
    public func multipling(by other: Size) -> Size {
        return self.zipWith(other, *)
    }
    
    public func adding(_ value: Value) -> Size {
        return self.map { $0 - value }
    }
    public func adding(_ other: Size) -> Size {
        return self.zipWith(other, +)
    }
}

extension Size where Value: FloatingPoint {
    public func dividing(by value: Value) -> Size {
        guard value != 0 else { return .zero }
        return self.map { $0 / value }
    }
    public func dividing(by other: Size) -> Size {
        return self.zipWith(other) { $1 != 0 ? $0 / $1 : 0 }
    }
}

// MARK: Inset

extension Size where Value: Numeric {
    public func inset(_ edges: Edges<Value>) -> Size {
        return Size(width: self.width - edges.left - edges.right,
                    height: self.height - edges.top - edges.bottom)
    }
    public func outset(_ edges: Edges<Value>) -> Size {
        return inset(edges.negated)
    }
}

extension Size {
    public func inset<A: Numeric>(_ edges: Edges<A>) -> Size where Value == Optional<A> {
        var insetSize = self
        if let w = insetSize.width {
            insetSize.width = w - edges.left - edges.right
        }
        if let h = insetSize.height {
            insetSize.height = h - edges.top - edges.bottom
        }
        return insetSize
    }
    
    public func outset<A: Numeric>(_ edges: Edges<A>) -> Size where Value == Optional<A> {
        return inset(edges.negated)
    }
}

// MARK: Clamped

extension Size where Value: Comparable {
    public func clamped(min: Size<Value>, max: Size<Value>) -> Size {
        return Size(
            width: self.width.clamped(min: min.width, max: max.width),
            height: self.height.clamped(min: min.height, max: max.height)
        )
    }
}

extension Size {
    public func clamped<A: Comparable>(min: Size<A>, max: Size<A>) -> Size where Value == Optional<A> {
        var clampedSize = self
        if let w = clampedSize.width {
            clampedSize.width = w.clamped(min: min.width, max: max.width)
        }
        if let h = clampedSize.height {
            clampedSize.height = h.clamped(min: min.height, max: max.height)
        }
        return clampedSize
    }
}

extension Size {
    /// Use the width or height if not nil, otherwise fallback to the provided size's dimensions.
    public func unwrapped<A>(or fallbackSize: Size<A>) -> Size<A> where Value == Optional<A> {
        return Size<A>(
            width: self.width ?? fallbackSize.width,
            height: self.height ?? fallbackSize.height
        )
    }
    
    /// Use the width or height if not nil, otherwise fallback to the provided size's dimensions.
    public func unwrapped<A>(or fallbackSize: Size<A?>) -> Size<A?> where Value == Optional<A> {
        return Size<A?>(
            width: self.width ?? fallbackSize.width,
            height: self.height ?? fallbackSize.height
        )
    }
}

extension Size: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "{ w:\(width), h:\(height) }"
    }
}

////////////////////////////
// MARK: - Rect
////////////////////////////

public struct Rect<Value> {
    public var origin: Point<Value>
    public var size: Size<Value>
    
    public init(origin: Point<Value>, size: Size<Value>) {
        self.origin = origin
        self.size = size
    }
    public init(x: Value, y: Value, width: Value, height: Value) {
        self.init(origin: .init(x: x, y: y),
                  size: .init(width: width, height: height))
    }
}
public typealias RectDbl = Rect<Double>

extension Rect {
    public func map<A>(_ transform: (Value) -> A) -> Rect<A> {
        return Rect<A>(
            origin: origin.map(transform),
            size: size.map(transform)
        )
    }
    public func zip<A>(_ other: Rect<A>) -> Rect<(Value, A)> {
        return Rect<(Value, A)>(
            origin: origin.zip(other.origin),
            size: size.zip(other.size)
        )
    }
    public func zipWith<A, B>(_ other: Rect<A>, _ combine: @escaping (Value, A) -> B) -> Rect<B> {
        return self.zip(other).map(combine)
    }
}

extension Rect: Equatable where Value: Equatable {
    public static func == (lhs: Rect<Value>, rhs: Rect<Value>) -> Bool {
        return lhs.origin == rhs.origin
            && lhs.size == rhs.size
    }
}

extension Rect where Value: Numeric {
    public static var zero: Rect {
        return Rect(origin: .zero, size: .zero)
    }
}

extension Rect where Value: Numeric {
    /// topLeft is origin, bottomRight is origin+size
    public var cornerPoints: Corners<Point<Value>> {
        return Corners<Point<Value>>(
            topLeft: origin,
            topRight: Point(x: origin.x + size.width,
                            y: origin.y),
            bottomLeft: Point(x: origin.x,
                              y: origin.y + size.height),
            bottomRight: Point(x: origin.x + size.width,
                               y: origin.y + size.height)
        )
    }
}

extension Rect where Value: Numeric {
    public func inset(by edges: Edges<Value>) -> Rect<Value> {
        return Rect<Value>(
            x: origin.x + edges.left,
            y: origin.y + edges.top,
            width: size.width - edges.left - edges.right,
            height: size.height - edges.top - edges.bottom
        )
    }
    public func inset(by val: Value) -> Rect<Value> {
        return self.inset(by: .init(val))
    }
    
    public func outset(by edges: Edges<Value>) -> Rect<Value> {
        return self.inset(by: edges.negated)
    }
    public func outset(by val: Value) -> Rect<Value> {
        return self.outset(by: .init(val))
    }
}

extension Rect: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "{ x:\(origin.x), y:\(origin.y), w:\(size.width), h:\(size.height) }"
    }
}

////////////////////////////
// MARK: - Edges
////////////////////////////

public struct Edges<Value> {
    public var top, left, bottom, right: Value
    
    public init(top: Value, left: Value, bottom: Value, right: Value) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}
public typealias EdgesDbl = Edges<Double>

extension Edges {
    public init(_ val: Value) {
        self.init(top: val, left: val, bottom: val, right: val)
    }
}

extension Edges {
    public func map<A>(_ transform: (Value) -> A) -> Edges<A> {
        return Edges<A>(
            top: transform(top),
            left: transform(left),
            bottom: transform(bottom),
            right: transform(right)
        )
    }
    public func zip<A>(_ other: Edges<A>) -> Edges<(Value, A)> {
        return Edges<(Value, A)>(
            top: (top, other.top),
            left: (left, other.left),
            bottom: (bottom, other.bottom),
            right: (right, other.right)
        )
    }
    public func zipWith<A, B>(_ other: Edges<A>, _ combine: @escaping (Value, A) -> B) -> Edges<B> {
        return self.zip(other).map(combine)
    }
}

extension Edges: Equatable where Value: Equatable {
    public static func == (lhs: Edges<Value>, rhs: Edges<Value>) -> Bool {
        return lhs.top == rhs.top
            && lhs.left == rhs.left
            && lhs.bottom == rhs.bottom
            && lhs.right == rhs.right
    }
    
    /// If all edge values are the same.
    public var isUniform: Bool {
        return self.top == self.right
            && self.right == self.bottom
            && self.bottom == self.left
    }
}

extension Edges where Value: Numeric {
    public static var zero: Edges {
        return Edges(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension Edges where Value: Numeric {
    public var negated: Edges {
        return self.map { $0 * -1 }
    }
}

extension Edges where Value: Numeric {
    public func adding(_ value: Value) -> Edges {
        return self.map { $0 + value }
    }
    public func adding(_ other: Edges) -> Edges {
        return self.zipWith(other, +)
    }
}

extension Edges: CustomDebugStringConvertible where Value: Equatable {
    public var debugDescription: String {
        if isUniform {
            return "{ \(top) }"
        } else {
            return "{ t: \(top), l: \(left), b: \(bottom), r: \(right) }"
        }
    }
}

////////////////////////////
// MARK: - Corners
////////////////////////////

public struct Corners<Value> {
    public var topLeft, topRight, bottomLeft, bottomRight: Value
    
    public init(topLeft: Value, topRight: Value, bottomLeft: Value, bottomRight: Value) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
}
public typealias CornersDbl = Corners<Double>

extension Corners {
    public init(_ val: Value) {
        self.init(topLeft: val, topRight: val, bottomLeft: val, bottomRight: val)
    }
}

extension Corners {
    public func map<A>(_ transform: (Value) -> A) -> Corners<A> {
        return Corners<A>(
            topLeft: transform(topLeft),
            topRight: transform(topRight),
            bottomLeft: transform(bottomLeft),
            bottomRight: transform(bottomRight)
        )
    }
    public func zip<A>(_ other: Corners<A>) -> Corners<(Value, A)> {
        return Corners<(Value, A)>(
            topLeft: (topLeft, other.topLeft),
            topRight: (topRight, other.topRight),
            bottomLeft: (bottomLeft, other.bottomLeft),
            bottomRight: (bottomRight, other.bottomRight)
        )
    }
    public func zipWith<A, B>(_ other: Corners<A>, _ combine: @escaping (Value, A) -> B) -> Corners<B> {
        return self.zip(other).map(combine)
    }
}

extension Corners: Equatable where Value: Equatable {
    public static func == (lhs: Corners<Value>, rhs: Corners<Value>) -> Bool {
        return lhs.topLeft == rhs.topLeft
            && lhs.topRight == rhs.topRight
            && lhs.bottomLeft == rhs.bottomLeft
            && lhs.bottomRight == rhs.bottomRight
    }
    
    /// If all corner values are the same.
    public var isUniform: Bool {
        return self.topLeft == self.topRight
            && self.topRight == self.bottomRight
            && self.bottomRight == self.bottomLeft
    }
}

extension Corners where Value: Numeric {
    public static var zero: Corners {
        return Corners(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
    }
}

extension Corners: CustomDebugStringConvertible where Value: Equatable {
    public var debugDescription: String {
        if isUniform {
            return "{ \(topLeft) }"
        } else {
            return "{ tL: \(topLeft), tR: \(topRight), bL: \(bottomLeft), bR: \(bottomRight) }"
        }
    }
}

////////////////////////////
// MARK: - Utilities
////////////////////////////

extension Comparable {
  /// Allow any comparable value to be clamped between a min & max value
  public func clamped(min: Self, max: Self) -> Self {
    return Swift.min(Swift.max(self, min), max)
  }
}
