//
//  TopicViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

final class TopicViewController: UIViewController {
    
    private let topicView = TopicView()
    private var topicPictureArray: [TopicView.TopicSection] = [
        .goldenHour([dummyTopicPictures, dummyTopicPictures, dummyTopicPictures]),
        .business([dummyTopicPictures, dummyTopicPictures, dummyTopicPictures, dummyTopicPictures, dummyTopicPictures, dummyTopicPictures]),
        .architecture([dummyTopicPictures, dummyTopicPictures, dummyTopicPictures, dummyTopicPictures, dummyTopicPictures])
    ]
    
    override func loadView() {
        view = topicView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureDelegate()
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
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
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TopicViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return topicPictureArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TopicPictureHeaderView.identifier,
                for: indexPath
            ) as? TopicPictureHeaderView else { return UICollectionReusableView() }
            header.configureView(sectionTitle: topicPictureArray[indexPath.section].sectionHeaderTitle)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch topicPictureArray[section] {
        case let .goldenHour(items):
            return items.count
        case let .business(items):
            return items.count
        case let .architecture(items):
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopicPictureCollectionViewCell.identifier,
            for: indexPath
        ) as? TopicPictureCollectionViewCell else { return UICollectionViewCell() }
        
        switch topicPictureArray[indexPath.section] {
        case let .goldenHour(items):
            print("")
        case let .business(items):
            print("")
        case let .architecture(items):
            print("")
        }
        
        return cell
    }
}
