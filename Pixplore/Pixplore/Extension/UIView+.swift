//
//  UIView+.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
