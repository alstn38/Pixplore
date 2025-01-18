//
//  StringLiterals.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import Foundation

enum StringLiterals {
    
    enum Search {
        static let title: String = "SEARCH PHOTO"
        static let searchBarPlaceholder: String = "키워드 검색"
        static let searchGuideText: String = "사진을 검색해보세요."
        static let searchNoResult: String = "검색 결과가 없어요."
        static let sortButtonRelevant: String = "관련순"
        static let sortButtonLatest: String = "최신순"
    }
    
    enum Topic {
        static let title: String = "OUR TOPIC"
    }
    
    enum DetailPicture {
        static let infoTitle: String = "정보"
        static let sizeTitle: String = "크기"
        static let viewCountTitle: String = "조회수"
        static let downloadTitle: String = "다운로드"
        static let viewTitle: String = "조회"
    }
    
    enum Alert {
        static let warningTitle: String = "경고"
        static let confirmTitle: String = "확인"
    }
}
