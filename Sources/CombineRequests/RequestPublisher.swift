//
//  RequestPublisher.swift
//  CombineRequests
//
//  Created by Thomas Leese on 18/10/2020.
//

import Combine

/// Publishes the state of a request from any other publisher.
public class RequestPublisher<StateSuccess, StateFailure>: Publisher where StateFailure: Error {
    public typealias Output = RequestState<StateSuccess, StateFailure>
    public typealias Failure = Never

    let subject = CurrentValueSubject<Output, Failure>(.loading)
    var cancellable: AnyCancellable?

    public init<P>(_ publisher: P) where P: Publisher, P.Output == StateSuccess, P.Failure == StateFailure {
        cancellable = publisher
            .sink { completion in
                if case .failure(let error) = completion {
                    self.subject.send(.failure(error))
                }
            } receiveValue: { data in
                self.subject.send(.success(data))
            }
    }

    public func receive<S>(subscriber: S) where S: Subscriber, S.Input == Output, S.Failure == Failure {
        subject.receive(subscriber: subscriber)
    }
}

public extension Publisher {
    func request() -> RequestPublisher<Self.Output, Self.Failure> {
        RequestPublisher(self)
    }

    func sink<StateSuccess, StateFailure>(
        receiveLoading: @escaping (() -> Void) = {},
        receiveSuccess: @escaping ((StateSuccess) -> Void) = { _ in },
        receiveFailure: @escaping ((StateFailure) -> Void) = { _ in }
    ) -> AnyCancellable where Output == RequestState<StateSuccess, StateFailure>, Failure == Never {
        sink { state in
            switch state {
            case .loading:
                receiveLoading()
            case .success(let output):
                receiveSuccess(output)
            case .failure(let error):
                receiveFailure(error)
            }
        }
    }

    func sinkRequest(
        receiveLoading: @escaping (() -> Void) = {},
        receiveSuccess: @escaping ((Self.Output) -> Void) = { _ in },
        receiveFailure: @escaping ((Self.Failure) -> Void) = { _ in }
    ) -> AnyCancellable {
        request().sink(receiveLoading: receiveLoading, receiveSuccess: receiveSuccess, receiveFailure: receiveFailure)
    }
}
