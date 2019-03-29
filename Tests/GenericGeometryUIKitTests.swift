//
//  GenericGeometryTests.swift
//  GenericGeometry
//
//  Created by Laurie Hufford on 28/03/2019.
//

import XCTest
@testable import GenericGeometry

#if canImport(UIKit)
import UIKit

class GenericGeometryUIKitTests: XCTestCase {

    func testUIEdgeInsets() {
        let edgeInsetsInt: UIEdgeInsets = Edges<Int>(top: 10, left: 9, bottom: 8, right: 7).uiEdgeInsets
        
        XCTAssertEqual(edgeInsetsInt, UIEdgeInsets(top: 10, left: 9, bottom: 8, right: 7))
        
        let edgeInsetsFlt: UIEdgeInsets = Edges<Double>(top: 1.5, left: 2.5, bottom: 3.5, right: 4.5).uiEdgeInsets
        
        XCTAssertEqual(edgeInsetsFlt, UIEdgeInsets(top: 1.5, left: 2.5, bottom: 3.5, right: 4.5))
    }

}

#endif
