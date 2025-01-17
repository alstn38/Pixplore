//
//  ColorFilter.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

enum ColorFilter: String, CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case purple
    case magenta
    case teal
    case black
    case white
    
    var uiColor: UIColor {
        switch self {
        case .red: return UIColor.red
        case .orange: return UIColor.orange
        case .yellow: return UIColor.yellow
        case .green: return UIColor.green
        case .blue: return UIColor.blue
        case .purple: return UIColor.purple
        case .magenta: return UIColor.magenta
        case .teal: return UIColor.systemTeal
        case .black: return UIColor.black
        case .white: return UIColor.white
        }
    }
    
    var description: String {
        switch self {
        case .red: return "레드"
        case .orange: return "오렌지"
        case .yellow: return "옐로우"
        case .green: return "그린"
        case .blue: return "블루"
        case .purple: return "퍼플"
        case .magenta: return "마젠타"
        case .teal: return "틸"
        case .black: return "블랙"
        case .white: return "화이트"
        }
    }
}
