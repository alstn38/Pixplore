//
//  TopicPictureHeaderView.swift
//  Pixplore
//
//  Created by 강민수 on 1/18/25.
//

import SnapKit
import UIKit

final class TopicPictureHeaderView: UICollectionReusableView {
    
    static let identifier  = String(describing: TopicPictureHeaderView.self)
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
    
    func configureView(sectionTitle: String) {
        sectionLabel.text = sectionTitle
    }
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubviews(sectionLabel)
    }
    
    private func configureLayout() {
        sectionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(10)
        }
    }
}
