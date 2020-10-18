//
//  RequestStoreTests.swift
//  CombineRequests
//
//  Created by Thomas Leese on 18/10/2020.
//

import Combine
import XCTest

@testable import CombineRequests

final class RequestStoreTests: XCTestCase {

    class Store: RequestStore {
        var isLoading: Bool = false
        var output: String?
        var error: NSError?
    }

    var store = Store()

    func testAssignStore() {
        _ = Result<String, NSError>.success("output").publisher
            .request()
            .assignRequest(to: \.store, on: self)

        XCTAssertFalse(store.isLoading)
        XCTAssertEqual(store.output, "output")
        XCTAssertNil(store.error)
    }

}
