//
//  ObservableRequest.swift
//  CombineRequests
//
//  Created by Thomas Leese on 18/10/2020.
//

import Combine

public class ObservableRequest<Success, Failure: Error>: ObservableObject {
    @Published fileprivate var state: RequestState<Success, Failure> = .loading

    public var isLoading: Bool = true
    public var output: Success?
    public var error: Failure?

    private var cancellable: AnyCancellable?

    public init() {
        cancellable = $state.sink { state in
            self.isLoading = state.isLoading

            if !state.isLoading {
                self.output = state.output
                self.error = state.error
            }
        }
    }
}

public extension Publisher {
    func assign<S, F>(to observableRequest: ObservableRequest<S, F>) where Output == RequestState<S, F>, Failure == Never {
        assign(to: &observableRequest.$state)
    }

    func assignRequest<S, F>(to observableRequest: ObservableRequest<S, F>) where Output == S, Failure == F {
        request().assign(to: observableRequest)
    }
}
