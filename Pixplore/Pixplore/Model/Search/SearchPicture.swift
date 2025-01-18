//
//  SearchPicture.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Foundation

struct SearchPicture: Decodable {
    let total: Int
    let totalPages: Int
    let results: [Picture]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
