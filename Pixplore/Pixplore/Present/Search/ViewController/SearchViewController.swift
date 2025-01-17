//
//  SearchViewController.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
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
    }
    
    private func configureNavigation() {
        navigationItem.title = StringLiterals.Search.title
        navigationItem.searchController = searchController
    }
}
