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
        layout.sectionInset = UIEdgeInsets(top: insetSpacing, left: insetSpacing, bottom: insetSpacing, right: insetSpacing * 10)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
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
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    let searchDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = StringLiterals.Search.searchGuideText
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    let sortingButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray6.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        button.backgroundColor = .white
        return button
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
    
    func configureSearchDescription(_ type: searchDescriptionType) {
        searchDescriptionLabel.isHidden = type.isHidden
        searchDescriptionLabel.text = type.description
    }
    
    func configureSortingButton(_ type: SortingButtonType) {
        var configuration = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = .boldSystemFont(ofSize: 12)
        configuration.attributedTitle = AttributedString(type.title, attributes: titleContainer)
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.image = type.image
        configuration.titleAlignment = .leading
        configuration.imagePadding = 10
        sortingButton.configuration = configuration
    }
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubviews(
            colorCollectionView,
            pictureCollectionView,
            searchDescriptionLabel,
            sortingButton
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
        
        searchDescriptionLabel.snp.makeConstraints {
            $0.center.equalTo(pictureCollectionView)
        }
        
        sortingButton.snp.makeConstraints {
            $0.bottom.equalTo(colorCollectionView).offset(1)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(8)
            $0.width.equalTo(95)
            $0.height.equalTo(26)
        }
    }
}

// MARK: - SortingButtonType
extension SearchView {
    enum SortingButtonType: String {
        case relevant
        case latest
        
        var title: String {
            switch self {
            case .relevant:
                return StringLiterals.Search.sortButtonRelevant
            case .latest:
                return StringLiterals.Search.sortButtonLatest
            }
        }
        
        var image: UIImage? {
            switch self {
            case .relevant:
                return UIImage(systemName: "line.horizontal.3.decrease")
            case .latest:
                return UIImage(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
            }
        }
        
        mutating func toggle() {
            switch self {
            case .relevant:
                self = .latest
            case .latest:
                self = .relevant
            }
        }
    }
}


// MARK: - searchDescriptionType
extension SearchView {
    
    enum searchDescriptionType {
        case searchGuide
        case noResult
        case hidden
        
        var description: String {
            switch self {
            case .searchGuide:
                return StringLiterals.Search.searchGuideText
            case .noResult:
                return StringLiterals.Search.searchGuideText
            case .hidden:
                return ""
            }
        }
        
        var isHidden: Bool {
            switch self {
            case .searchGuide:
                return false
            case .noResult:
                return false
            case .hidden:
                return true
            }
        }
    }
}
