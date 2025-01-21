//
//  ShortsCollectionViewCell.swift
//  Pixplore
//
//  Created by 강민수 on 1/21/25.
//

import SnapKit
import UIKit

final class ShortsCollectionViewCell: UICollectionViewCell {
    
    private let shortsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.text = "강민수" // TODO: 이후 삭제
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let pictureDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.text = "2021년 5월 4일 게시됨" // TODO: 이후 삭제
        label.textColor = .white
        label.numberOfLines = 1
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
    
    private func configureHierarchy() {
        addSubviews(
            shortsImageView,
            userProfileImageView,
            userNameLabel,
            pictureDateLabel
        )
    }
    
    private func configureLayout() {
        shortsImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        userProfileImageView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(20)
            $0.size.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView).offset(8)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(15)
        }
        
        pictureDateLabel.snp.makeConstraints {
            $0.top.equalTo(userNameLabel.snp.bottom).offset(3)
            $0.leading.equalTo(userProfileImageView.snp.trailing).offset(15)
        }
    }
}
