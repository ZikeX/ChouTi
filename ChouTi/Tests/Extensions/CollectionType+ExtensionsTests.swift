//
//  CollectionType+ExtensionsTests.swift
//  ChouTi
//
//  Created by Honghao Zhang on 2016-07-02.
//  Copyright © 2016 Honghaoz. All rights reserved.
//

@testable import ChouTi
import XCTest

class CollectionType_ExtensionsTests: XCTestCase {

    var integers: [Int] = []

    override func setUp() {
        super.setUp()

        integers = [1, 2, 3, 4, 5]
    }

    func testSafeSubscript() {
        XCTAssertEqual(integers[safe: -1], nil)
        XCTAssertEqual(integers[safe: 0], 1)
        XCTAssertEqual(integers[safe: 2], 3)
        XCTAssertEqual(integers[safe: 5], nil)
    }
}
