//
//  TopicEndPoint.swift
//  Pixplore
//
//  Created by 강민수 on 1/19/25.
//

import Alamofire
import Foundation

enum TopicEndPoint: EndPointProtocol {
    case searchPicture(topicID: String)
}

extension TopicEndPoint {
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.baseURL
    }
    
    var path: String {
        switch self {
        case .searchPicture(let topicID):
            return "/topics/\(topicID)/photos"
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
        case .searchPicture:
            return nil
        }
    }
}
