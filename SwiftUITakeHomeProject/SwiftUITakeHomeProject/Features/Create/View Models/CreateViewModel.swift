//
//  CreateViewModel.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 20..
//

import Foundation

final class CreateViewModel: ObservableObject {
    @Published var newPeople = NewPeople()
    @Published private(set) var state: CreateUserState?
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false

    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        
        let encoded = try? encoder.encode(newPeople)
        NetworkingManager.shared.request(absoluteURL: "https://reqres.in/api/users", methodType: .POST(data: encoded)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.state = .successfull
                case .failure(let error):
                    self?.state = .unsuccessfull
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}

extension CreateViewModel {
    enum CreateUserState {
        case successfull, unsuccessfull
    }
}
