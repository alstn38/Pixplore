//
//  DateFormatterManager.swift
//  Pixplore
//
//  Created by 강민수 on 1/21/25.
//

import Foundation

final class DateFormatterManager {
    
    private let serverDateFormatter = ISO8601DateFormatter()
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월 d일 게시됨"
        return dateFormatter
    }()
    
    static let shared = DateFormatterManager()
    
    private init() { }
    
    func getPublishedDateString(from dateString: String) -> String {
        guard let date = serverDateFormatter.date(from: dateString) else {
            return StringLiterals.DetailPicture.noInformation
        }
        
        let formattedDateString = dateFormatter.string(from: date)
        
        return formattedDateString
    }
}
