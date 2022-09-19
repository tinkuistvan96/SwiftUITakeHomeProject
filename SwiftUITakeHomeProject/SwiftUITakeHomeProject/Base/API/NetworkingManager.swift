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
    
    func request<T: Codable>(absoluteURL: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkingError.custom(error: error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.httpError(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
        }
        
        dataTask.resume()
    }
}

extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidURL
        case custom(error: Error)
        case httpError(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
