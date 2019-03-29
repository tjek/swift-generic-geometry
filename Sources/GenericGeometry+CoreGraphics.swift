//
//  ┌────┬─┐         ┌─────┐
//  │  ──┤ └─┬───┬───┤  ┌──┼─┬─┬───┐
//  ├──  │ ╷ │ · │ · │  ╵  │ ╵ │ ╷ │
//  └────┴─┴─┴───┤ ┌─┴─────┴───┴─┴─┘
//               └─┘
//
//  Copyright (c) 2019 ShopGun. All rights reserved.

import CoreGraphics

// MARK: - Replace Values with CGFloats

extension Point where Value: BinaryFloatingPoint {
    public var withCGFloats: Point<CGFloat> {
        return self.map { CGFloat($0) }
    }
}
extension Point where Value: BinaryInteger {
    public var withCGFloats: Point<CGFloat> {
        return self.map { CGFloat($0) }
    }
}

extension Size where Value: BinaryFloatingPoint {
    public var withCGFloats: Size<CGFloat> {
        return self.map { CGFloat($0) }
    }
}
extension Size where Value: BinaryInteger {
    public var withCGFloats: Size<CGFloat> {
        return self.map { CGFloat($0) }
    }
}

extension Rect where Value: BinaryFloatingPoint {
    public var withCGFloats: Rect<CGFloat> {
        return self.map { CGFloat($0) }
    }
}
extension Rect where Value: BinaryInteger {
    public var withCGFloats: Rect<CGFloat> {
        return self.map { CGFloat($0) }
    }
}

extension Edges where Value: BinaryFloatingPoint {
    public var withCGFloats: Edges<CGFloat> {
        return self.map { CGFloat($0) }
    }
}
extension Edges where Value: BinaryInteger {
    public var withCGFloats: Edges<CGFloat> {
        return self.map { CGFloat($0) }
    }
}

extension Corners where Value: BinaryFloatingPoint {
    public var withCGFloats: Corners<CGFloat> {
        return self.map { CGFloat($0) }
    }
}
extension Corners where Value: BinaryInteger {
    public var withCGFloats: Corners<CGFloat> {
        return self.map { CGFloat($0) }
    }
}

// MARK: - Convert To/From CG counterparts

extension Point where Value: BinaryFloatingPoint {
    public init(cgPoint: CGPoint) {
        self.init(x: .init(cgPoint.x), y: .init(cgPoint.y))
    }
    public var cgPoint: CGPoint {
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
}
extension Point where Value: BinaryInteger {
    public init(cgPoint: CGPoint) {
        self.init(x: .init(cgPoint.x), y: .init(cgPoint.y))
    }
    public var cgPoint: CGPoint {
        return CGPoint(x: CGFloat(x), y: CGFloat(y))
    }
}

extension Size where Value: BinaryFloatingPoint {
    public init(cgSize: CGSize) {
        self.init(width: .init(cgSize.width), height: .init(cgSize.height))
    }
    public var cgSize: CGSize {
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}
extension Size where Value: BinaryInteger {
    public init(cgSize: CGSize) {
        self.init(width: .init(cgSize.width), height: .init(cgSize.height))
    }
    public var cgSize: CGSize {
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
}

extension Rect where Value: BinaryFloatingPoint {
    public init(cgRect: CGRect) {
        self.init(origin: Point(cgPoint: cgRect.origin),
                  size: Size(cgSize: cgRect.size))
    }
    public var cgRect: CGRect {
        return CGRect(origin: origin.cgPoint,
                      size: size.cgSize)
    }
}
extension Rect where Value: BinaryInteger {
    public init(cgRect: CGRect) {
        self.init(origin: Point(cgPoint: cgRect.origin),
                  size: Size(cgSize: cgRect.size))
    }
    public var cgRect: CGRect {
        return CGRect(origin: origin.cgPoint,
                      size: size.cgSize)
    }
}

extension Edges {
    public var cgRectEdges: [CGRectEdge: Value] {
        return [
            .minYEdge: self.top,
            .maxYEdge: self.bottom,
            .minXEdge: self.left,
            .maxXEdge: self.right
        ]
    }
    
    public func value(forEdge edge: CGRectEdge) -> Value {
        switch edge {
        case .minXEdge: // left
            return left
        case .maxXEdge: // right
            return right
        case .minYEdge: // top
            return top
        case .maxYEdge: // bottom
            return bottom
        }
    }
}
