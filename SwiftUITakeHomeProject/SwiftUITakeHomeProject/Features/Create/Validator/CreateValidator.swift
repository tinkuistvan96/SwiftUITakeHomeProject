//
//  CreateValidator.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 21..
//

import Foundation

struct CreateValidator {
    enum CreateValidatorError: LocalizedError {
        case invalidFirstName, invalidLastName, invalidJob
        
        var errorDescription: String? {
            switch self {
            case .invalidFirstName:
                return "First name field can't be empty."
            case .invalidLastName:
                return "Last name field can't be empty."
            case .invalidJob:
                return "Job field can't be empty."
            }
        }
    }
    
    func validate(_ newPeople: NewPeople) throws {
        if newPeople.firstName.isEmpty {
            throw CreateValidatorError.invalidFirstName
        }
        
        if newPeople.lastName.isEmpty {
            throw CreateValidatorError.invalidLastName
        }
        
        if newPeople.job.isEmpty {
            throw CreateValidatorError.invalidJob
        }
    }
}
