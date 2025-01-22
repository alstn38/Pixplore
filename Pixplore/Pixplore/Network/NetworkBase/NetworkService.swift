//
//  NetworkService.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Alamofire

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() { }
    
    func request<T: Decodable>(
        endPoint: EndPointProtocol,
        responseType: T.Type,
        completionHandler: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = endPoint.url else {
            return completionHandler(.failure(.invalidURL))
        }
        
        AF.request(
            url,
            method: endPoint.httpMethod,
            parameters: endPoint.parameters,
            headers: endPoint.headers
        )
        .validate(statusCode: 200...299)
        .responseDecodable(of: T.self) { [weak self] response in
            guard let self else { return }
            switch response.result {
            case .success(let value):
                completionHandler(.success(value))
            case .failure(let error):
                let errorType = self.getNetworkError(error)
                completionHandler(.failure(errorType))
            }
        }
    }
    
    private func getNetworkError(_ error: AFError) -> NetworkError {
        if error.underlyingError is DecodingError {
            return .decodeError
        }
        
        switch error.responseCode {
        case 400: return .badRequest
        case 401: return .unauthorized
        case 403: return .forbidden
        case 404: return.notFound
        case 500: return .severError
        case 503: return .severError
        default: return .unknown
        }
    }
}
