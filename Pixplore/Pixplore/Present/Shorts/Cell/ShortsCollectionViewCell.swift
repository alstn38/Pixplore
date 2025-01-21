//
//  ShortsCollectionViewCell.swift
//  Pixplore
//
//  Created by 강민수 on 1/21/25.
//

import Kingfisher
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
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    
    private let pictureDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
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
    
    func configureCell(_ picture: Picture) {
        userNameLabel.text = picture.user.name
        pictureDateLabel.text = picture.createdAt
        
        let userProfileURL = URL(string: picture.user.profileImage.mediumSizeLink)
        userProfileImageView.kf.setImage(with: userProfileURL)
        
        let shortsImageURL = URL(string: picture.urls.originalLink)
        shortsImageView.kf.setImage(with: shortsImageURL) // TODO: 이미지 resize
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
