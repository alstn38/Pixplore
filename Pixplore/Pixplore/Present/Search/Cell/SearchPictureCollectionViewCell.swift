//
//  SearchPictureCollectionViewCell.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import SnapKit
import UIKit

final class SearchPictureCollectionViewCell: UICollectionViewCell {
    
    private let searchedPictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let starBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .yellow
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let starCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1,543" // TODO: 서버 통신 이후 삭제
        label.textColor = .white
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        
    }
    
    private func configureHierarchy() {
        addSubviews(
            searchedPictureImageView,
            starBackgroundView,
            starImageView,
            starCountLabel
        )
    }
    
    private func configureLayout() {
        searchedPictureImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        starBackgroundView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(15)
            $0.height.equalTo(26)
            $0.trailing.equalTo(starCountLabel).offset(10)
        }
        
        starImageView.snp.makeConstraints {
            $0.leading.equalTo(starBackgroundView).offset(10)
            $0.size.equalTo(13)
            $0.centerY.equalTo(starBackgroundView)
        }
        
        starCountLabel.snp.makeConstraints {
            $0.leading.equalTo(starImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(starBackgroundView)
        }
    }
}
