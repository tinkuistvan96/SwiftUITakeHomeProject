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
    @Published private(set) var isLoading = false
    
    @MainActor
    func fetchUsers() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let response = try await NetworkingManager.shared.request(endpoint: .people, type: UsersResponse.self)
            users = response.data
        } catch {
            hasError = true
            if let networkingError = error as? NetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = NetworkingManager.NetworkingError.custom(error: error)
            }
        }
    }
}
