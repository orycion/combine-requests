//
//  RequestPublisherTests.swift
//  CombineRequests
//
//  Created by Thomas Leese on 18/10/2020.
//

import Combine
import XCTest

@testable import CombineRequests

final class RequestPublisherTests: XCTestCase {

    struct ExampleError: Error, Equatable { }

    func testPublisherIsLoading() {
        var isLoading: Bool?
        _ = PassthroughSubject<String, ExampleError>().request().sink { state in
            isLoading = state.isLoading
        }
        XCTAssertTrue(isLoading ?? false)
    }

    func testPublisherOutput() {
        var output: String?
        _ = Just("output").request().sink { state in
            output = state.output
        }
        XCTAssertEqual(output, "output")
    }

    func testPublisherError() {
        var error: ExampleError?
        _ = Result<String, ExampleError>.failure(.init()).publisher.request().sink { state in
            error = state.error
        }
        XCTAssertEqual(error, ExampleError())
    }

}
