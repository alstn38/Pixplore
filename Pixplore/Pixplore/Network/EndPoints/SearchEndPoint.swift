//
//  SearchEndPoint.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Alamofire
import Foundation

enum SearchEndPoint: EndPointProtocol {
    case searchPicture(
        query: String,
        page: Int,
        perPage: Int = 20,
        orderBy: String,
        color: String?
    )
}

extension SearchEndPoint {
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.baseURL
    }
    
    var path: String {
        switch self {
        case .searchPicture:
            return "/search/photos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .searchPicture:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": Secret.clientID]
    }
    
    var parameters: Parameters? {
        switch self {
        case .searchPicture(let query, let page, let perPage, let orderBy, let color):
            var parameters: [String: Any] = [
                "query": query,
                "page": page,
                "per_page": perPage,
                "order_by": orderBy
            ]
            
            if let color {
                parameters["color"] = color
            }
            
            return parameters
        }
    }
}
