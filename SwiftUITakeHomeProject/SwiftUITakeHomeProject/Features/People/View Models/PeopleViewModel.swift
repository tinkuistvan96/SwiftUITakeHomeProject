//
//  PeopleViewModel.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

final class PeopleViewModel: ObservableObject {
    //private(set) means: we can access this variable from other class but can't change it
    @Published private(set) var users = [User]()
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    @Published private(set) var viewState: PeopleViewState?
    private var page = 1
    private var totalPages : Int?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching 
    }
    
    @MainActor
    func fetchUsers() async {
        reset()
        viewState = .loading
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(endpoint: .people(page: page), type: UsersResponse.self)
            users = response.data
            totalPages = response.totalPages
        } catch {
            hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = NetworkingManager.NetworkingError.custom(error: error)
            }
        }
    }
    
    @MainActor
    func fetchNextPageOfUsers() async {
        guard page != totalPages else {
            return
        }
        
        page += 1
        
        viewState = .fetching
        defer { viewState = .finished }
        do {
            let response = try await NetworkingManager.shared.request(endpoint: .people(page: page), type: UsersResponse.self)
            users += response.data
        } catch {
            hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = NetworkingManager.NetworkingError.custom(error: error)
            }
        }
    }
    
    func hasReachedEnd(of user: User) -> Bool {
        users.last?.id == user.id
    }
    
    func reset() {
        if viewState == .finished {
            page = 1
            viewState = nil
            totalPages = nil
            users.removeAll()
        }
    }
}

extension PeopleViewModel {
    enum PeopleViewState {
        case fetching, loading, finished
    }
}
