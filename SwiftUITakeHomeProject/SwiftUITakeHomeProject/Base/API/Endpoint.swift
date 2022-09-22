//
//  Endpoint.swift
//  SwiftUITakeHomeProject
//
//  Created by Tinku István on 2022. 09. 22..
//

import Foundation
import CoreImage

enum Endpoint {
    case people(page: Int)
    case detail(id: Int)
    case create(data: Data?)
}

extension Endpoint {
    var host: String { "reqres.in" }
    
    var path: String {
        switch self {
        case .people, .create:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .people(let page):
            return ["page": "\(page)"]
        default:
            return nil
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var queryItems = self.queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        
        #if DEBUG
        queryItems?.append(URLQueryItem(name: "delay", value: "1"))
        #endif
        
        urlComponents.queryItems = queryItems
        
        return urlComponents.url
    }
}

extension Endpoint {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
    
    var methodType: MethodType {
        switch self {
        case .people, .detail:
            return MethodType.GET
        case .create(let data):
            return MethodType.POST(data: data)
        }
    }
}
