//
//  ShortsViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/21/25.
//

import UIKit

final class ShortsViewController: UIViewController {
    
    private let shortsView = ShortsView()
    private var timer: Timer?
    private var timerCount: Float = 0.0
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
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
                if self.shortsPictureArray.isEmpty {
                    self.pageToNextPicture()
                }
                self.shortsPictureArray.append(contentsOf: value)
            case .failure(let error):
                self.presentWarningAlert(message: error.description)
            }
        }
    }
    
    private func pageToNextPicture() {
        let duration: Float = 5.0
        timerCount = 0
        shortsView.progressView.setProgress(0, animated: false)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self else { return }
            timerCount += 0.05
            let progress = timerCount / duration
            shortsView.progressView.setProgress(progress, animated: true)
            
            if timerCount >= duration {
                timerCount = 0
                timer.invalidate()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let picture = shortsPictureArray[indexPath.item]
        let detailPictureViewController = DetailPictureViewController(picture: picture)
        navigationController?.pushViewController(detailPictureViewController, animated: true)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageHeight = scrollView.frame.height
        let currentPage = Int((scrollView.contentOffset.y + pageHeight / 2) / pageHeight)
        pageToNextPicture()
    }
}
