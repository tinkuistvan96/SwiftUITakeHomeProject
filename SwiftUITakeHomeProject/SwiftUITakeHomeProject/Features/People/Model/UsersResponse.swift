//
//  UsersResponse.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

//MARK: - UsersResponse
struct UsersResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [User]
    let support: Support
}
