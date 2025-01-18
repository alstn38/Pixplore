//
//  DetailPictureViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import UIKit

final class DetailPictureViewController: UIViewController {
    
    private let detailPictureView = DetailPictureView()
    
    override func loadView() {
        view = detailPictureView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
