//
//  Dispatcher.swift
//  UseCase-Combine
//
//  Created by MSI on 12.04.2021.
//

import Foundation

public class Dispatcher<CommandType: Command> {
    public typealias Handler = (CommandType) -> Void

    private let handler: Handler

    init(handler: @escaping Handler) {
        self.handler = handler
    }

    /// this method dispatch command to Handler
    /// - Parameter command: A Command that request process to handler
    public func dispatch(_ command: CommandType) {
        handler(command)
    }
}