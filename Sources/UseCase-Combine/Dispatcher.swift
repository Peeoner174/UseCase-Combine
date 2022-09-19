//
//  Dispatcher.swift
//  UseCase-Combine
//
//  Created by Pavel Kochenda on 12.04.2021.
//

import Foundation
import Combine

public class Dispatcher<CommandType: Command> {
    public typealias Handler = (CommandType) -> Void

    private let handler: Handler

    init(handler: @escaping Handler) {
        self.handler = handler
    }

    public func dispatch<S: Scheduler>(
        _ command: CommandType,
        on scheduler: S,
        options: S.SchedulerOptions? = nil
    ) {
        scheduler.schedule(options: options) { [weak self] in
            self?.handler(command)
        }
    }
}
