//
//  UIViewController+.swift
//  Pixplore
//
//  Created by 강민수 on 1/19/25.
//

import UIKit

extension UIViewController {
    
    func presentWarningAlert(message: String) {
        let alert = UIAlertController(
            title: StringLiterals.Alert.warningTitle,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: StringLiterals.Alert.confirmTitle,
            style: .default
        )
        
        alert.addAction(action)
        present(alert, animated: true)
    }
}
