//
//  ExampleFetchUseCase.swift
//  UseCase-CombineTests
//
//  Created by Pavel Kochenda on 20/09/2022.
//

import UIKit
import UseCase_Combine
import Foundation
import Combine

enum FetchState<ObjectType: Equatable>: Equatable {
    case initial
    case loading
    case object(ObjectType)
    case empty
    case error(Error)
    case complete
    
    public static func == (lhs: FetchState<ObjectType>, rhs: FetchState<ObjectType>) -> Bool {
        switch (lhs, rhs) {
        case (let .object(lhsObject), let .object(rhsObject)):
            return lhsObject == rhsObject
        case (.initial, .initial):
            return true
        case (.loading, .loading):
            return true
        case (.empty, .empty):
            return true
        case (let .error(lhsError), let .error(rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

enum RandomImageFetchCommand: Command {
    typealias State = FetchState<UIImage>
    case fetchRandomImage
}

class LocalRandomImageFetchExecutor: CommandExecutor {
    typealias CommandType = RandomImageFetchCommand

    func execute(with store: Store<FetchState<UIImage>>) -> ExecuteDispatchHandler {
        { _ in
            sleep(2) // some long task on current thread for test
            store.update { fetchState in
                guard let image = UIImage(systemName: "heart.fill") else {
                    fetchState = .empty
                    return
                }
                fetchState = .object(image)
            }
        }
    }
}
