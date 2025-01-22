//
//  NetworkResult.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case severError
    case decodeError
    case unknown
    
    var description: String {
        switch self {
        case .invalidURL:
            return "Failed to create url"
        case .badRequest:
            return "The request was unacceptable, often due to missing a required parameter"
        case .unauthorized:
            return "Invalid Access Token"
        case .forbidden:
            return "Missing permissions to perform request"
        case .notFound:
            return "The requested resource doesn’t exist"
        case .severError:
            return "Something went wrong on our end"
        case .decodeError:
            return "Decoding failed"
        case .unknown:
            return "Unknown Error"
        }
    }
}
