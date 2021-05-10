//
//  Store.swift
//  UseCase-Combine
//
//  Created by MSI on 12.04.2021.
//

import Foundation
import Combine

public class Store<State: Equatable> {

    private class Container {
        var events: [State]
        var state: State { didSet { events.append(self.state) } }

        init(state: State) {
            self.state = state
            self.events = [state]
        }
    }

    private let container: Container

    public let stateRelay: StateRelay<State>
    public let eventsRelay: EventsSourcingRelay<State>

    public var currentState: State {
        container.state
    }

    public init(state: State) {
        let container = Container(state: state)
        stateRelay = .init(container.state)
        eventsRelay = .init(container.events)
        self.container = container
    }

    public func update(updater: @escaping (inout State) -> Void) {
        updater(&self.container.state)
        stateRelay.accept(self.container.state)
        eventsRelay.accept(self.container.events)
    }
}
