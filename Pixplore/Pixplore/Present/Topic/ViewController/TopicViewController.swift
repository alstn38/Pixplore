//
//  TopicViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

final class TopicViewController: UIViewController {
    
    private let topicView = TopicView()
    private var selectedTopic: [TopicView.TopicPictureType] = [.goldenHour, .business, .architecture]
    private var topicPictureDictionary: [TopicView.TopicPictureType: [Picture]] = [:]
    
    override func loadView() {
        view = topicView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureDelegate()
        fetchTopicPicture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.Topic.title
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
    
    private func getTopicPicture(topic: TopicView.TopicPictureType) {
        let endPoint = TopicEndPoint.searchPicture(topicID: topic.topicID)
        
        NetworkService.shared.request(endPoint: endPoint, responseType: [Picture].self) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                self.topicPictureDictionary[topic] = value
                self.topicView.topicPictureCollectionView.reloadData()
            case .failure(let error):
                self.presentWarningAlert(message: error.description)
            }
        }
    }
    
    private func fetchTopicPicture() {
        selectedTopic.forEach { topic in
            getTopicPicture(topic: topic)
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
        let detailPictureViewController = DetailPictureViewController()
        navigationController?.pushViewController(detailPictureViewController, animated: true)
    }
}
