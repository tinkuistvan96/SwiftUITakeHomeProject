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
    
    func fetchUsers() {
        NetworkingManager.shared.request(absoluteURL: "https://reqres.in/api/users",
                                         type: UsersResponse.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.users = response.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
