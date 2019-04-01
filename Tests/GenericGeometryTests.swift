//
//  GenericGeometryTests.swift
//  GenericGeometry
//
//  Created by Laurie Hufford on 28/03/2019.
//

import XCTest
@testable import GenericGeometry

class GenericGeometryTests: XCTestCase {

    func testPoint() {
        
        let boolPoint = Point(x: true, y: false)
        XCTAssertEqual(boolPoint.x, true)
        XCTAssertEqual(boolPoint.y, false)
        
        let intPoint = Point(5)
        XCTAssertEqual(intPoint.x, intPoint.y)
        XCTAssertEqual(intPoint.y, 5)
        
        let dblPoint = Point<Double>(x: 0.5, y: 2)
        
        let scaledPoint = intPoint
            .map(Double.init)
            .zipWith(dblPoint, *)
        XCTAssert(scaledPoint == Point<Double>(x: 2.5, y: 10))
        
        let zero = Point<Int>.zero
        XCTAssertEqual(zero, Point<Int>(0))
    }

}
