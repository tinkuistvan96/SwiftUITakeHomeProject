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
    
    func fetchUsers() {
        isLoading = true
        NetworkingManager.shared.request(endpoint: .people,
                                         type: UsersResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                defer { self?.isLoading = false }
                switch result {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
