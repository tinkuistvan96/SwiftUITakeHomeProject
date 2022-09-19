//
//  Models.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

// MARK: - User
struct User: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}
