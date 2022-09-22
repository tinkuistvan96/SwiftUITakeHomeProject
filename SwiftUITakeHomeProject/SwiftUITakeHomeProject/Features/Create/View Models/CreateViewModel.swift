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

    @MainActor
    func create() async {
        do {
            try validator.validate(newPeople)
            
            state = .submitting
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let encoded = try? encoder.encode(newPeople)
            
            try await NetworkingManager.shared.request(endpoint: .create(data: encoded))
            
            state = .successfull
        } catch {
            hasError = true
            state = .unsuccessfull
            
            switch error {
            case is NetworkingManager.NetworkingError:
                self.error = .networking(error: error as! NetworkingManager.NetworkingError)
            case is CreateValidator.CreateValidatorError:
                self.error = .validation(error: error as! CreateValidator.CreateValidatorError)
            default:
                self.error = .system(error: error)
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
        case system(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .networking(let err):
                return err.errorDescription
            case .validation(let err):
                return err.errorDescription
            case .system(let err):
                return err.localizedDescription
            }
        }
    }
}
