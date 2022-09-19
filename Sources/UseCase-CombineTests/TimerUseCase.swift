//
//  TimerUseCase.swift
//  UseCase-CombineTests
//
//  Created by Pavel Kochenda on 20/09/2022.
//

import UseCase_Combine

enum TimerState: Equatable {
    case pause(Int)
    case counting(Int)
    case stopped
    
    var count: Int {
        switch self {
        case let .counting(num): return num
        case let .pause(num): return num
        case .stopped: return 0
        }
    }
}

enum TimerCommand: Command {
    typealias State = TimerState
    case start
    case stop
    case reset
}

class TimerCommandExecutor: CommandExecutor {
    typealias CommandType = TimerCommand
    
    private var timer: Timer?
    
    func execute(with store: Store<CommandType.State>) -> ExecuteDispatchHandler {
        { [weak self] timerCommand in
            guard let self = self else { return }
            switch timerCommand {
            case .start:
                self.timer?.invalidate()
                store.update { timerState in
                    timerState = .counting(timerState.count)
                }
                self.timer = .scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    store.update { timerState in
                        timerState = .counting(timerState.count + 1) }
                }
            case .stop:
                self.timer?.invalidate()
                store.update { timerState in
                    timerState = .pause(timerState.count)
                }
            case .reset:
                self.timer?.invalidate()
                store.update { timerState in
                    timerState = .stopped
                }
            }
        }
    }
}

extension TimerCommandExecutor {
    func asAnyCommandExecutor() -> AnyCommandExecutor<CommandType> {
        AnyCommandExecutor<CommandType>(self)
    }
}

extension UseCase {
    static func timer() -> UseCase<TimerCommand> {
        .store(.stopped, commandExecutor: TimerCommandExecutor().asAnyCommandExecutor())
    }
}
