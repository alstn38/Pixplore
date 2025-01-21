//
//  ShortsView.swift
//  Pixplore
//
//  Created by 강민수 on 1/21/25.
//

import SnapKit
import UIKit

final class ShortsView: UIView {
    
    let shortsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
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
        shortsCollectionView.contentOffset.y = .zero
    }
    
    private func configureHierarchy() {
        addSubview(shortsCollectionView)
    }
    
    private func configureLayout() {
        shortsCollectionView.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
