//
//  TopicViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

final class TopicViewController: UIViewController {
    
    private let topicView = TopicView()
    private var selectedTopic: [TopicPictureType] = []
    private var topicPictureDictionary: [TopicPictureType: [Picture]] = [:]
    private let refreshControl = UIRefreshControl()
    private var isRecentlyRefreshed: Bool = false
    
    override func loadView() {
        view = topicView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegate()
        fetchTopicPicture()
        configureRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func configureDelegate() {
        topicView.topicPictureCollectionView.delegate = self
        topicView.topicPictureCollectionView.dataSource = self
        topicView.topicPictureCollectionView.register(
            TopicPictureCollectionViewCell.self,
            forCellWithReuseIdentifier: TopicPictureCollectionViewCell.identifier
        )
        topicView.topicPictureCollectionView.register(
            TopicPictureHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TopicPictureHeaderView.identifier
        )
    }
    
    private func configureRefreshControl() {
        topicView.topicPictureCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlDidChanged), for: .valueChanged)
    }
    
    private func getTopicPicture(topic: TopicPictureType, dispatchGroup: DispatchGroup) {
        let endPoint = TopicEndPoint.searchPicture(topicID: topic.topicID)
        
        NetworkService.shared.request(endPoint: endPoint, responseType: [Picture].self) { [weak self] response in
            guard let self else { return }
            dispatchGroup.leave()
            switch response {
            case .success(let value):
                self.topicPictureDictionary[topic] = value
            case .failure(let error):
                self.presentWarningAlert(message: error.description)
            }
        }
    }
    
    private func fetchTopicPicture() {
        recentlyRefreshCheck()
        selectedTopic = Array(TopicPictureType.allCases.shuffled().prefix(3))
        topicPictureDictionary.removeAll()
        
        let dispatchGroup = DispatchGroup()
        selectedTopic.forEach { topic in
            dispatchGroup.enter()
            getTopicPicture(topic: topic, dispatchGroup: dispatchGroup)
        }
        
        dispatchGroup.notify(queue: .main) {
            self.refreshControl.endRefreshing()
            self.topicView.topicPictureCollectionView.reloadData()
        }
    }
    
    @objc private func refreshControlDidChanged(_ sender: UIRefreshControl) {
        switch isRecentlyRefreshed {
        case true:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.refreshControl.endRefreshing()
            }
        case false:
            isRecentlyRefreshed = true
            fetchTopicPicture()
        }
    }
    
    private func recentlyRefreshCheck() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.isRecentlyRefreshed = false
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return topicPictureDictionary.keys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TopicPictureHeaderView.identifier,
                for: indexPath
            ) as? TopicPictureHeaderView else { return UICollectionReusableView() }
            
            let topic = selectedTopic[indexPath.section]
            header.configureView(sectionTitle: topic.sectionHeaderTitle)
            
            return header
            
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let topic = selectedTopic[section]
        guard let topicPictureCount = topicPictureDictionary[topic]?.count else { return 0 }
        return topicPictureCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopicPictureCollectionViewCell.identifier,
            for: indexPath
        ) as? TopicPictureCollectionViewCell else { return UICollectionViewCell() }
        
        let topic = selectedTopic[indexPath.section]
        guard let topicPictureArray = topicPictureDictionary[topic] else { return UICollectionViewCell() }
        
        cell.configureCell(topicPictureArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let topic = selectedTopic[indexPath.section]
        guard let topicPictureArray = topicPictureDictionary[topic] else { return }
        let picture = topicPictureArray[indexPath.row]
        let detailPictureViewModel = DetailPictureViewModel(picture: picture)
        let detailPictureViewController = DetailPictureViewController(viewModel: detailPictureViewModel)
        navigationController?.pushViewController(detailPictureViewController, animated: true)
    }
}
