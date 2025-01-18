//
//  SearchView.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import SnapKit
import UIKit

final class SearchView: UIView {
    
    let colorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let insetSpacing: CGFloat = 10
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = insetSpacing
        layout.sectionInset = UIEdgeInsets(top: insetSpacing, left: insetSpacing, bottom: insetSpacing, right: insetSpacing)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    let pictureCollectionView: UICollectionView = {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let insetSpacing: CGFloat = 5
        let cellLength: CGFloat = (screenWidth - insetSpacing)/2
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = insetSpacing
        layout.minimumLineSpacing = insetSpacing
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: cellLength, height: cellLength / 3 * 4)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
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
        addSubviews(
            colorCollectionView,
            pictureCollectionView
        )
    }
    
    private func configureLayout() {
        colorCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(34)
        }
        
        pictureCollectionView.snp.makeConstraints {
            $0.top.equalTo(colorCollectionView.snp.bottom).offset(10)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
