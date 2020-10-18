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

    func testAssignStore() {
        let store = ObservableRequest<String, NSError>()
        Result<String, NSError>.success("output").publisher
            .assignRequest(to: store)

        XCTAssertFalse(store.isLoading)
        XCTAssertEqual(store.output, "output")
        XCTAssertNil(store.error)
    }

}
