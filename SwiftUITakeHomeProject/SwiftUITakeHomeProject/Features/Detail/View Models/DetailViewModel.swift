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
    
    func fetchUserInfo(id: Int) {
        isLoading = true
        NetworkingManager.shared.request(absoluteURL: "https://reqres.in/api/users/\(id)",
                                         type: UserDetailResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                defer { self?.isLoading = false }
                switch result {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
