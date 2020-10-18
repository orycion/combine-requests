//
//  RequestStore.swift
//  CombineRequests
//
//  Created by Thomas Leese on 18/10/2020.
//

import Combine

public protocol RequestStore {
    associatedtype Success
    associatedtype Failure: Error

    var isLoading: Bool { get set }
    var output: Success? { get set }
    var error: Failure? { get set }
}

public extension Publisher {
    func assignRequest<Root, Store: RequestStore>(
        to keyPath: ReferenceWritableKeyPath<Root, Store>, on object: Root
    ) -> AnyCancellable where Self.Output == RequestState<Store.Success, Store.Failure>, Self.Failure == Never {
        sink { state in
            object[keyPath: keyPath].isLoading = state.isLoading
            object[keyPath: keyPath].output = state.output
            object[keyPath: keyPath].error = state.error
        }
    }
}
