//
//  NetworkingManager.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 19..
//

import Foundation

class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable>(endpoint: Endpoint,
                             type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = createRequest(url: url, methodType: endpoint.methodType)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.httpError(statusCode: statusCode)
        }
        
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        return res
    }
    
    func request(endpoint: Endpoint) async throws {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        let request = createRequest(url: url, methodType: endpoint.methodType)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            let statusCode = (response as! HTTPURLResponse).statusCode
            throw NetworkingError.httpError(statusCode: statusCode)
        }
    }
}

//MARK: - Errors
extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case httpError(statusCode: Int)
        case invalidData
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "URL isn't valid"
            case .custom(let error):
                return "Something went wrong \(error.localizedDescription)"
            case .httpError(let statusCode):
                return "Something went wrong \(statusCode)"
            case .invalidData:
                return "Response data is invalid"
            case .failedToDecode:
                return "Failed to decode"
            }
        }
    }
}

//MARK: - Request helper
extension NetworkingManager {
    private func createRequest(url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        
        return request
    }
}
