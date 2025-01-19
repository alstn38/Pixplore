//
//  SearchViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let colorFilterArray: [ColorFilter] = ColorFilter.allCases
    private var colorFilterType: ColorFilter?
    private var sortingType: SearchView.SortingButtonType = .relevant
    private var totalPage: Int = 1
    private var currentPage: Int = 1
    private var recentSearchedText: String?
    private var searchDescriptionType: SearchView.searchDescriptionType = .searchGuide {
        didSet {
            searchView.configureSearchDescription(searchDescriptionType)
        }
    }
    private var searchPictureArray: [Picture] = [] {
        didSet {
            searchView.pictureCollectionView.reloadData()
            searchDescriptionType = searchPictureArray.isEmpty ? .noResult : .hidden
        }
    }
    
    private let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = StringLiterals.Search.searchBarPlaceholder
        return searchController
    }()
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureDelegate()
        configureAddTarget()
        searchView.configureSortingButton(sortingType)
        searchView.configureSearchDescription(searchDescriptionType)
    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.Search.title
        navigationItem.searchController = searchController
    }
    
    private func configureDelegate() {
        searchController.searchBar.delegate = self
        
        searchView.colorCollectionView.delegate = self
        searchView.colorCollectionView.dataSource = self
        searchView.colorCollectionView.register(
            ColorCollectionViewCell.self,
            forCellWithReuseIdentifier: ColorCollectionViewCell.identifier
        )
        
        searchView.pictureCollectionView.delegate = self
        searchView.pictureCollectionView.dataSource = self
        searchView.pictureCollectionView.prefetchDataSource = self
        searchView.pictureCollectionView.register(
            SearchPictureCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchPictureCollectionViewCell.identifier
        )
    }
    
    private func configureAddTarget() {
        searchView.sortingButton.addTarget(self, action: #selector(sortingButtonDidTap), for: .touchUpInside)
    }
    
    private func getSearchedPicture(query: String) {
        let endPoint = SearchEndPoint.searchPicture(
            query: query,
            page: currentPage,
            orderBy: sortingType.rawValue,
            color: colorFilterType?.rawValue
        )
        
        NetworkService.shared.request(endPoint: endPoint, responseType: SearchPicture.self) { [weak self] response in
            guard let self else { return }
            switch response {
            case .success(let value):
                self.fetchSearchedPicture(value)
            case .failure(let error):
                self.presentWarningAlert(message: error.description)
            }
        }
    }
    
    private func fetchSearchedPicture(_ value: SearchPicture) {
        if currentPage == 1 {
            totalPage = value.totalPages
            searchPictureArray = value.results
        } else {
            searchPictureArray.append(contentsOf: value.results)
        }
    }
    
    @objc private func sortingButtonDidTap(_ sender: UIButton) {
        sortingType.toggle()
        searchView.configureSortingButton(sortingType)
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedText = searchBar.text,
            !searchedText.isEmpty
        else { return }
        
        currentPage = 1
        recentSearchedText = searchedText
        getSearchedPicture(query: searchedText)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case searchView.colorCollectionView:
            return colorFilterArray.count
        case searchView.pictureCollectionView:
            return searchPictureArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case searchView.colorCollectionView:
            let colorFilter = colorFilterArray[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ColorCollectionViewCell.identifier,
                for: indexPath
            ) as? ColorCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(colorFilter)
            cell.configureCell(isSelected: colorFilter == colorFilterType)
            
            return cell
            
        case searchView.pictureCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchPictureCollectionViewCell.identifier,
                for: indexPath
            ) as? SearchPictureCollectionViewCell else { return UICollectionViewCell() }
            
            cell.configureCell(searchPictureArray[indexPath.item])
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case searchView.colorCollectionView:
            let isSameFilter: Bool = colorFilterType == colorFilterArray[indexPath.item]
            colorFilterType = isSameFilter ? nil : colorFilterArray[indexPath.item]
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
            cell.configureCell(isSelected: !isSameFilter)
            
            guard let recentSearchedText else { return }
            currentPage = 1
            getSearchedPicture(query: recentSearchedText)
            
        case searchView.pictureCollectionView:
            print(#function)
        default:
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch collectionView {
        case searchView.colorCollectionView:
            guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell else { return }
            cell.configureCell(isSelected: false)
        case searchView.pictureCollectionView:
            print(#function)
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard
            let recentSearchedText = recentSearchedText,
            collectionView == searchView.pictureCollectionView,
            indexPaths.map({ $0.item }).contains(searchPictureArray.count - 2),
            currentPage < totalPage
        else { return }
        
        currentPage += 1
        getSearchedPicture(query: recentSearchedText)
    }
}
