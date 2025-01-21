//
//  DetailPictureViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import UIKit

final class DetailPictureViewController: UIViewController {
    
    private let detailPictureView = DetailPictureView()
    private var detailPicture: DetailPicture?
    private let picture: Picture
    
    init(picture: Picture) {
        self.picture = picture
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailPictureView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
        detailPictureView.configureView(picture: picture)
        getDetailPicture(imageID: picture.id)
    }
    
    private func configureAddTarget() {
        detailPictureView.chartSegmentedControl.addTarget(self, action: #selector(chartSegmentedControlDidChange), for: .valueChanged)
    }
    
    private func getDetailPicture(imageID: String) {
        let endPoint = PictureEndPoint.detailPicture(imageID: imageID)
        
        NetworkService.shared.request(endPoint: endPoint, responseType: DetailPicture.self) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                self.detailPicture = value
                detailPictureView.configureView(detailPicture: value)
            case .failure(let error):
                self.presentWarningAlert(message: error.description)
            }
        }
    }
    
    @objc private func chartSegmentedControlDidChange(_ sender: UISegmentedControl) {
        guard let detailPicture else { return }
        detailPictureView.configureView(detailPicture: detailPicture)
    }
}
