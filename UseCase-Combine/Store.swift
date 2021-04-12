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
        var state: State

        init(state: State) {
            self.state = state
        }
    }

    private let container: Container

    let stateRelay: StateRelay<State>

    public var currentState: State {
        return container.state
    }

    public init(state: State) {
        let container = Container(state: state)
        stateRelay = .init(container.state)
        self.container = container
    }

    public func update(updater: @escaping (inout State) -> Void) {
        var state = self.container.state
        updater(&state)
        self.stateRelay.accept(state)
    }
}
