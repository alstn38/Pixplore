//
//  ColorCollectionViewCell.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import SnapKit
import UIKit

final class ColorCollectionViewCell: UICollectionViewCell {
    
    private let roundBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
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
    
    func configureCell(_ colorType: ColorFilter) {
        colorView.backgroundColor = colorType.uiColor
        colorLabel.text = colorType.description
    }
    
    private func configureHierarchy() {
        addSubviews(
            roundBackgroundView,
            colorView,
            colorLabel
        )
    }
    
    private func configureLayout() {
        roundBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        colorView.snp.makeConstraints {
            $0.leading.equalTo(roundBackgroundView).offset(5)
            $0.centerY.equalTo(roundBackgroundView)
            $0.size.equalTo(20)
        }
        
        colorLabel.snp.makeConstraints {
            $0.leading.equalTo(colorView.snp.trailing).offset(5)
            $0.centerY.equalTo(roundBackgroundView)
            $0.trailing.equalTo(roundBackgroundView).inset(10)
            $0.verticalEdges.equalTo(roundBackgroundView).inset(5)
        }
    }
}
