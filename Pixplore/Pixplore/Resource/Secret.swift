//
//  Secret.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Foundation

enum Secret {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    static let clientID: String = Bundle.main.infoDictionary?["CLIENT_ID"] as? String ?? ""
}
