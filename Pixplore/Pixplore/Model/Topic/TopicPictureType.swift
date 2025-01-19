//
//  TopicPictureType.swift
//  Pixplore
//
//  Created by 강민수 on 1/19/25.
//

import Foundation

enum TopicPictureType: CaseIterable {
    
    case goldenHour
    case business
    case architecture
    case wallpapers
    case nature
    case renders3D
    case travel
    case texturesPatterns
    case streetPhotography
    case film
    case archival
    case experimental
    case animals
    case fashionBeauty
    case people
    case businessWork
    case foodDrink
    
    var sectionHeaderTitle: String {
        switch self {
        case .goldenHour:
            return "골든 아워"
        case .business:
            return "비즈니스 및 업무"
        case .architecture:
            return "건축 및 인테리어"
        case .wallpapers:
            return "배경 화면"
        case .nature:
            return "자연"
        case .renders3D:
            return "3D 렌더링"
        case .travel:
            return "여행"
        case .texturesPatterns:
            return "텍스처 및 패턴"
        case .streetPhotography:
            return "거리 사진"
        case .film:
            return "필름"
        case .archival:
            return "기록 보관소"
        case .experimental:
            return "실험적인"
        case .animals:
            return "동물"
        case .fashionBeauty:
            return "패션 및 뷰티"
        case .people:
            return "사람"
        case .businessWork:
            return "비즈니스 및 업무"
        case .foodDrink:
            return "식음료"
        }
    }
    
    var topicID: String {
        switch self {
        case .goldenHour:
            return "golden-hour"
        case .business:
            return "business-work"
        case .architecture:
            return "architecture-interior"
        case .wallpapers:
            return "wallpapers"
        case .nature:
            return "nature"
        case .renders3D:
            return "3d-renders"
        case .travel:
            return "travel"
        case .texturesPatterns:
            return "textures-patterns"
        case .streetPhotography:
            return "street-photography"
        case .film:
            return "film"
        case .archival:
            return "archival"
        case .experimental:
            return "experimental"
        case .animals:
            return "animals"
        case .fashionBeauty:
            return "fashion-beauty"
        case .people:
            return "people"
        case .businessWork:
            return "business-work"
        case .foodDrink:
            return "food-drink"
        }
    }
}
