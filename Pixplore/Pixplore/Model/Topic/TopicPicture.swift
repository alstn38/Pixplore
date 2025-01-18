//
//  TopicPicture.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Foundation

// MARK: - TopicPicture
struct TopicPicture: Decodable {
    let id: String
    let createdAt: Date
    let width: Int
    let height: Int
    let urls: URLs
    let likes: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width
        case height
        case urls
        case likes
        case user
    }
}

// MARK: - URLs
struct URLs: Decodable {
    let originalLink: String
    let smallSizeLink: String

    enum CodingKeys: String, CodingKey {
        case originalLink = "raw"
        case smallSizeLink = "small"
    }
}

// MARK: - User
struct User: Decodable {
    let name: String
    let profileImage: ProfileImage

    enum CodingKeys: String, CodingKey {
        case name
        case profileImage = "profile_image"
    }
}

// MARK: - ProfileImage
struct ProfileImage: Codable {
    let mediumSizeLink: String
    
    enum CodingKeys: String, CodingKey {
        case mediumSizeLink = "medium"
    }
}

let dummyTopicPictures: TopicPicture = TopicPicture(
    id: "1",
    createdAt: Date(), // 현재 시간 사용
    width: 1920,
    height: 1080,
    urls: URLs(
        originalLink: "https://example.com/original_image_1.jpg",
        smallSizeLink: "https://example.com/small_image_1.jpg"
    ),
    likes: 123,
    user: User(
        name: "John Doe",
        profileImage: ProfileImage(
            mediumSizeLink: "https://example.com/profile_image_1.jpg"
        )
    )
)
