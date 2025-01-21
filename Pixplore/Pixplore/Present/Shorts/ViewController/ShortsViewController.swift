//
//  ShortsViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/21/25.
//

import UIKit

final class ShortsViewController: UIViewController {
    
    private let shortsView = ShortsView()
    private var shortsPictureArray: [Picture] = [] {
        didSet {
            shortsView.shortsCollectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = shortsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        getShortsPicture()
    }
    
    private func configureCollectionView() {
        shortsView.shortsCollectionView.delegate = self
        shortsView.shortsCollectionView.dataSource = self
        shortsView.shortsCollectionView.register(
            ShortsCollectionViewCell.self,
            forCellWithReuseIdentifier: ShortsCollectionViewCell.identifier
        )
    }
    
    private func getShortsPicture() {
        let endPoint = PictureEndPoint.randomPicture
        
        NetworkService.shared.request(endPoint: endPoint, responseType: [Picture].self) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                self.shortsPictureArray.append(contentsOf: value)
            case .failure(let error):
                self.presentWarningAlert(message: error.description)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ShortsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shortsPictureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShortsCollectionViewCell.identifier,
            for: indexPath
        ) as? ShortsCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(shortsPictureArray[indexPath.item])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShortsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = shortsView.shortsCollectionView.frame.width
        let height = shortsView.shortsCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

// MARK: - UIScrollViewDelegate
extension ShortsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            self.shortsView.shortsCollectionView.setContentOffset(.zero, animated: false)
        }
    }
}
