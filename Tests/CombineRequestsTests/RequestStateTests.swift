//
//  RequestStateTests.swift
//  CombineRequests
//
//  Created by Thomas Leese on 18/10/2020.
//

import Foundation
import XCTest

@testable import CombineRequests

final class RequestStateTests: XCTestCase {

    struct ExampleError: Error, Equatable { }

    func testIsLoading() {
        var state: RequestState<String, Error>

        state = .loading
        XCTAssertTrue(state.isLoading)

        state = .success("output")
        XCTAssertFalse(state.isLoading)

        state = .failure(NSError())
        XCTAssertFalse(state.isLoading)
    }

    func testData() {
        var state: RequestState<String, Error>

        state = .loading
        XCTAssertNil(state.data)

        state = .success("output")
        XCTAssertEqual(state.data, "output")

        state = .failure(ExampleError())
        XCTAssertNil(state.data)
    }

    func testError() {
        var state: RequestState<String, Error>

        state = .loading
        XCTAssertNil(state.error)

        state = .success("output")
        XCTAssertNil(state.error)

        state = .failure(ExampleError())
        XCTAssertEqual(state.error as? ExampleError, ExampleError())
    }

}
