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
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    let validator = CreateValidator()

    func create() {
        do {
            try validator.validate(newPeople)
            
            state = .submitting
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
                        if let networkingError = error as? NetworkingManager.NetworkingError {
                            self?.error = FormError.networking(error: networkingError)
                        }
                    }
                }
            }
        } catch {
            hasError = true
            if let validationError = error as? CreateValidator.CreateValidatorError {
                self.error = FormError.validation(error: validationError)
            }
        }
    }
}

extension CreateViewModel {
    enum CreateUserState {
        case successfull, unsuccessfull, submitting
    }
    
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        
        var errorDescription: String? {
            switch self {
            case .networking(let err):
                return err.errorDescription
            case .validation(let err):
                return err.errorDescription
            }
        }
    }
}
