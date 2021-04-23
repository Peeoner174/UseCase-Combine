//
//  StateRelay.swift
//  UseCase-Combine
//
//  Created by MSI on 12.04.2021.
//

import Foundation
import Combine

public final class CurrentValueRelay<Output>: Publisher {
    private let subject: CurrentValueSubject<Output, Never>
    
    public typealias Failure = Never
    
    public init(_ value: Output) {
        subject = .init(value)
    }
    
    public func receive<S: Subscriber>(subscriber: S) where CurrentValueRelay.Failure == S.Failure, CurrentValueRelay.Output == S.Input {
        subject.receive(subscriber: subscriber)
    }
    
    public var value: Output {
        subject.value
    }
    
    public func accept(_ value: Output) {
        subject.send(value)
    }
}

public typealias StateRelay<State: Equatable> = CurrentValueRelay<State>
public typealias EventsSourcingRelay<State: Equatable> = CurrentValueRelay<[State]>
 
