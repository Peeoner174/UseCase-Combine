//
//  CommandErasure.swift
//  UseCase-Combine
//
//  Created by Pavel Kochenda on 20/09/2022.
//

public class AnyCommandExecutor<CommandType: Command>: CommandExecutor {
    private let box: _AnyCommandExecutor<CommandType>
    
    public init<CommandExecutorType: CommandExecutor>(_ commandExecutor: CommandExecutorType) where CommandExecutorType.CommandType == CommandType {
        self.box = _AnyCommandExecutorBox(commandExecutor)
    }
    
    public func execute(with store: Store<CommandType.State>) -> (CommandType) -> Void {
        box.execute(with: store)
    }
}

private class _AnyCommandExecutorBox<Base: CommandExecutor>: _AnyCommandExecutor<Base.CommandType> {
    private let base: Base
    
    init(_ base: Base) {
        self.base = base
    }
    
    override func execute(with store: Store<Base.CommandType.State>) -> (Base.CommandType) -> Void {
        base.execute(with: store)
    }
}

private class _AnyCommandExecutor<CommandType: Command>: CommandExecutor {
    public func execute(with store: Store<CommandType.State>) -> (CommandType) -> Void {
        fatalError("This method is abstract")
    }
}
