//
//  DetailPicture.swift
//  Pixplore
//
//  Created by 강민수 on 1/19/25.
//

import Foundation

struct DetailPicture: Codable {
    let id: String
    let downloads: DataCount
    let views: DataCount
    let likes: DataCount
}

// MARK: - DataCount
struct DataCount: Codable {
    let total: Int
    let historical: Historical
}

// MARK: - Historical
struct Historical: Codable {
    let statistic: [Statistic]
    
    enum CodingKeys: String, CodingKey {
        case statistic = "values"
    }
}

// MARK: - DataDate
struct Statistic: Codable {
    let date: String
    let views: Int
    
    enum CodingKeys: String, CodingKey {
        case date
        case views = "value"
    }
}
