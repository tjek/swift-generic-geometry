//
//  ┌────┬─┐         ┌─────┐
//  │  ──┤ └─┬───┬───┤  ┌──┼─┬─┬───┐
//  ├──  │ ╷ │ · │ · │  ╵  │ ╵ │ ╷ │
//  └────┴─┴─┴───┤ ┌─┴─────┴───┴─┴─┘
//               └─┘
//
//  Copyright (c) 2019 ShopGun. All rights reserved.

#if canImport(UIKit)

import UIKit

extension Edges where Value: BinaryFloatingPoint {
    public var uiEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(
            top: CGFloat(top),
            left: CGFloat(left),
            bottom: CGFloat(bottom),
            right: CGFloat(right)
        )
    }
}
extension Edges where Value: BinaryInteger {
    public var uiEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(
            top: CGFloat(top),
            left: CGFloat(left),
            bottom: CGFloat(bottom),
            right: CGFloat(right)
        )
    }
}

#endif
