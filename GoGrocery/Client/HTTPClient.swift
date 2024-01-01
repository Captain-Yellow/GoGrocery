//
//  HTTPClient.swift
//  GoGrocery
//
//  Created by Mohammad Afshar on 16/12/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidResponce
    case decodingError
    case serverError(String)
    case badRequest
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .badRequest:
                return NSLocalizedString("Unable to perform Request", comment: "Bad Request")
            case .decodingError:
                return NSLocalizedString("Unable to decode Successfully", comment: "Decoding Error")
            case .serverError(let errorMessage):
                return NSLocalizedString(errorMessage, comment: "Server Error")
            case .invalidResponce:
                return NSLocalizedString("Invalid Response", comment: "Invalid Response")
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
        }
    }
}

struct Resourse<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var methodType: T.Type
}

//extension Resourse {
//    init(url: URL, method: HTTPMethod, methodType: T.Type) {
//        self.url = url
//        self.method = method
//        self.methodType = methodType
//    }
//}

struct HTTPClient {
    func load<T: Codable>(_ resourse: Resourse<T>) async throws -> T {
        var request = URLRequest(url: resourse.url)
        
        switch resourse.method {
            case .get(let queryItems):
                var components = URLComponents(url: resourse.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                
                guard let url = components?.url else {
                    throw NetworkError.badRequest
                }
                
                request = URLRequest(url: url)
            case .post(let data):
                request.httpMethod = resourse.method.name
                request.httpBody = data
            case .delete:
                request.httpMethod = resourse.method.name
        }
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        let session = URLSession(configuration: configuration)
//        async let (data, _) = session.data(for: URLRequest(url: resourse.url))
        let (data, _) = try await session.data(for: request)
        
        guard let resault = try? JSONDecoder().decode(resourse.methodType, from: data) else {
            throw NetworkError.decodingError
        }
        
        return resault
    }
}
