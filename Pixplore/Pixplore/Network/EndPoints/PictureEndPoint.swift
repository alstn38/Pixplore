//
//  PictureEndPoint.swift
//  Pixplore
//
//  Created by 강민수 on 1/19/25.
//

import Alamofire
import Foundation

enum PictureEndPoint: EndPointProtocol {
    case detailPicture(imageID: String)
}

extension PictureEndPoint {
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var baseURL: String {
        return Secret.baseURL
    }
    
    var path: String {
        switch self {
        case .detailPicture(let imageID):
            return "/photos/\(imageID)/statistics"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .detailPicture:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization": Secret.clientID]
    }
    
    var parameters: Parameters? {
        switch self {
        case .detailPicture:
            return nil
        }
    }
}
