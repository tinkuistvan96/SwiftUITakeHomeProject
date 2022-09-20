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
    
    func create() {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        
        let encoded = try? encoder.encode(newPeople)
        NetworkingManager.shared.request(absoluteURL: "https://reqres.in/api/users", methodType: .POST(data: encoded)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success():
                    self?.state = .successfull
                case .failure(_):
                    self?.state = .unsuccessfull
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
