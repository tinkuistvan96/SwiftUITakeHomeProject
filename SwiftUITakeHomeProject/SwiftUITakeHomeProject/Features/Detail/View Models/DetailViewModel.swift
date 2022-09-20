//
//  DetailViewModel.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published private(set) var userInfo: UserDetailResponse?
    
    func fetchUserInfo(id: Int) {
        NetworkingManager.shared.request(absoluteURL: "https://reqres.in/api/users/\(id)",
                                         type: UserDetailResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.userInfo = response
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}