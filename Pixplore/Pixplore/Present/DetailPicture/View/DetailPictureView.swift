//
//  DetailPictureView.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import Kingfisher
import SnapKit
import UIKit

final class DetailPictureView: UIView {
    
    private let detailScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
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
        label.numberOfLines = 1
        return label
    }()
    
    private let pictureDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let detailPictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiterals.DetailPicture.infoTitle
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let sizeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiterals.DetailPicture.sizeTitle
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let viewsCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiterals.DetailPicture.viewCountTitle
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let downloadTitleLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiterals.DetailPicture.downloadTitle
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let downloadLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
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
  
    func configureView(picture: Picture) {
        let profileURL = URL(string: picture.user.profileImage.mediumSizeLink)
        let detailImageURL = URL(string: picture.urls.originalLink)
        userProfileImageView.kf.setImage(with: profileURL)
        detailPictureImageView.kf.setImage(with: detailImageURL)
        userNameLabel.text = picture.user.name
        pictureDateLabel.text = picture.createdAt
        sizeLabel.text = "\(picture.width) x \(picture.height)"
        
        let screenWidth = UIScreen.main.bounds.width
        let verticalRatio: CGFloat = CGFloat(picture.height) / CGFloat(picture.width)
        detailPictureImageView.snp.updateConstraints {
            $0.height.equalTo(screenWidth * verticalRatio)
        }
    }
    
    func configureView(detailPicture: DetailPicture) {
        viewsCountLabel.text = detailPicture.views.total.formatted()
        downloadLabel.text = detailPicture.downloads.total.formatted()
    }
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubview(detailScrollView)
        detailScrollView.addSubview(contentView)
        contentView.addSubviews(
            userProfileImageView,
            userNameLabel,
            pictureDateLabel,
            detailPictureImageView,
            infoTitleLabel,
            sizeTitleLabel,
            viewsCountTitleLabel,
            downloadTitleLabel,
            sizeLabel,
            viewsCountLabel,
            downloadLabel
        )
    }
    
    private func configureLayout() {
        detailScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(detailScrollView)
            $0.width.equalTo(detailScrollView)
        }
        
        userProfileImageView.snp.makeConstraints {
            $0.top.leading.equalTo(detailScrollView).inset(20)
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
        
        detailPictureImageView.snp.makeConstraints {
            $0.top.equalTo(userProfileImageView.snp.bottom).offset(15)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        infoTitleLabel.snp.makeConstraints {
            $0.top.equalTo(detailPictureImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        sizeTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(infoTitleLabel.snp.trailing).offset(60)
            $0.centerY.equalTo(infoTitleLabel)
        }
        
        viewsCountTitleLabel.snp.makeConstraints {
            $0.top.equalTo(sizeTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(sizeTitleLabel)
        }
        
        downloadTitleLabel.snp.makeConstraints {
            $0.top.equalTo(viewsCountTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(sizeTitleLabel)
        }
        
        sizeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(sizeTitleLabel)
        }
        
        viewsCountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(viewsCountTitleLabel)
        }
        
        downloadLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(downloadTitleLabel)
            $0.bottom.equalToSuperview().inset(50)
        }
    }
}
