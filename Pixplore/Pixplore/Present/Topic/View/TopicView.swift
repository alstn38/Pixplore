//
//  TopicView.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import SnapKit
import UIKit

final class TopicView: UIView {
    
    let topicPictureCollectionView: UICollectionView = {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 5, leading: 5, bottom: 5, trailing: 5
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.45),
            heightDimension: .fractionalWidth(0.45 / 3 * 4)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(40)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 20, bottom: 0, trailing: 20
        )
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubviews(topicPictureCollectionView)
    }
    
    private func configureLayout() {
        topicPictureCollectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
