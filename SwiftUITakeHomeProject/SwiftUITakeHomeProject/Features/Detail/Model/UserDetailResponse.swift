//
//  UserDetailResponse.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

// MARK: - UserDetailResponse
struct UserDetailResponse: Codable {
    let data: User
    let support: Support
}
