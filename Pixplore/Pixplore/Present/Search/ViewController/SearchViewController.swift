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
    private var sortingType: SearchView.SortingButtonType = .relevant
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
        
//        let endPoint = SearchEndPoint.searchPicture(query: "banana", page: 1, perPage: 20, orderBy: "latest", color: "green")
//        NetworkService.shared.request(endPoint: endPoint, responseType: SearchPicture.self) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.description)
//            }
//        }
    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.Search.title
        navigationItem.searchController = searchController
    }
    
    private func configureDelegate() {
        searchController.delegate = self
        
        searchView.colorCollectionView.delegate = self
        searchView.colorCollectionView.dataSource = self
        searchView.colorCollectionView.register(
            ColorCollectionViewCell.self,
            forCellWithReuseIdentifier: ColorCollectionViewCell.identifier
        )
        
        searchView.pictureCollectionView.delegate = self
        searchView.pictureCollectionView.dataSource = self
        searchView.pictureCollectionView.register(
            SearchPictureCollectionViewCell.self,
            forCellWithReuseIdentifier: SearchPictureCollectionViewCell.identifier
        )
    }
    
    private func configureAddTarget() {
        searchView.sortingButton.addTarget(self, action: #selector(sortingButtonDidTap), for: .touchUpInside)
    }
    
    @objc private func sortingButtonDidTap(_ sender: UIButton) {
        sortingType.toggle()
        searchView.configureSortingButton(sortingType)
    }
}

// MARK: - UISearchControllerDelegate
extension SearchViewController: UISearchControllerDelegate {
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case searchView.colorCollectionView:
            return colorFilterArray.count
        case searchView.pictureCollectionView:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case searchView.colorCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ColorCollectionViewCell.identifier,
                for: indexPath
            ) as? ColorCollectionViewCell else { return UICollectionViewCell() }
            cell.configureCell(colorFilterArray[indexPath.row])
            return cell
        case searchView.pictureCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchPictureCollectionViewCell.identifier,
                for: indexPath
            ) as? SearchPictureCollectionViewCell else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
