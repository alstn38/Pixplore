//
//  EndPointProtocol.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Alamofire
import Foundation

protocol EndPointProtocol {
    var url: URL? { get }
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String: String]? { get }
    var params: Parameters? { get }
}
