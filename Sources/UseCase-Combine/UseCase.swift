//
//  UseCase.swift
//  UseCase-Combine
//
//  Created by Pavel Kochenda on 12.04.2021.
//

import Foundation
import Combine

public protocol Command {
    associatedtype State: Equatable
}

public protocol CommandExecutor {
    associatedtype CommandType: Command
    typealias ExecuteDispatchHandler = (CommandType) -> Void
    func execute(with store: Store<CommandType.State>) -> ExecuteDispatchHandler
}

public extension CommandExecutor {
    func asAnyCommandExecutor() -> AnyCommandExecutor<CommandType> {
        AnyCommandExecutor<CommandType>(self)
    }
}

public class UseCase<CommandType: Command> {
    public let dispatcher: Dispatcher<CommandType>
    public let state: StateRelay<CommandType.State>
    public let eventsSourcing: EventsSourcingRelay<CommandType.State>

    init(dispatcher: Dispatcher<CommandType>, store: Store<CommandType.State>) {
        self.dispatcher = dispatcher
        self.state = store.stateRelay
        self.eventsSourcing = store.eventsRelay
    }
}

public extension UseCase {
    typealias Handler = (CommandType) -> Void

    static func store(_ state: CommandType.State,
                      commandExecutor: AnyCommandExecutor<CommandType>) -> UseCase<CommandType> {
        let store = Store(state: state)
        let handler: (CommandType) -> Void = commandExecutor.execute(with: store)

        return UseCase<CommandType>(dispatcher: Dispatcher<CommandType> { handler($0) }, store: store)
    }
}
