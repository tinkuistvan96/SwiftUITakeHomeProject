//
//  DetailViewModel.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published private(set) var userInfo: UserDetailResponse?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    @Published private(set) var isLoading = false
    
    @MainActor
    func fetchUserInfo(id: Int) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let response = try await NetworkingManager.shared.request(endpoint: .detail(id: id), type: UserDetailResponse.self)
            userInfo = response
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
