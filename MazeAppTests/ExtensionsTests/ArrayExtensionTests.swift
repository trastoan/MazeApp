//
//  ArrayExtensionTests.swift
//  MazeAppTests
//
//  Created by Yuri on 27/04/22.
//

import XCTest
@testable import MazeApp

class ArrayExtensionTests: XCTestCase {

    func test_whenThereAreDuplicates_returnArrayWithUnique() throws {
        let sut = [1,2,3,4,5,5,3,4,2]

        let outcome = sut.unique()
        let expected = 5
        let ordered = outcome.sorted()

        XCTAssertEqual(outcome.count, expected)
        XCTAssertEqual(ordered, [1,2,3,4,5])
    }

    func test_whenThereAreNoDuplicates_returnSameSize() throws {
        let sut = [1,2,3,4,5]

        let outcome = sut.unique()
        let expected = 5
        let ordered = outcome.sorted()

        XCTAssertEqual(outcome.count, expected)
        XCTAssertEqual(ordered, [1,2,3,4,5])
    }

}

