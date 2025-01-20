//
//  UIImage+.swift
//  Pixplore
//
//  Created by 강민수 on 1/20/25.
//

import UIKit

extension UIImage {
    
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        let newSize = CGSize(width: newWidth, height: newHeight)
        let resized = UIGraphicsImageRenderer(size: newSize)
        let resizedImage = resized.image { context in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
        
        return resizedImage
    }
}
