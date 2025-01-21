//
//  PixploreTabBarController.swift
//  Pixplore
//
//  Created by 강민수 on 1/17/25.
//

import UIKit

final class PixploreTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        configureTabBarAppearance()
    }
    
    private func configureTabBarController() {
        let topicViewController = TopicViewController()
        topicViewController.tabBarItem = UITabBarItem(
            title: "Topic",
            image: UIImage(systemName: "chart.line.uptrend.xyaxis"),
            selectedImage: UIImage(systemName: "chart.line.uptrend.xyaxis")
        )
        
        let shortsViewController = ShortsViewController()
        shortsViewController.tabBarItem = UITabBarItem(
            title: "Shorts",
            image: UIImage(systemName: "play.square.stack"),
            selectedImage: UIImage(systemName: "play.square.stack")
        )
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        let topicNavigationController = UINavigationController(rootViewController: topicViewController)
        let shortsNavigationController = UINavigationController(rootViewController: shortsViewController)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        configureNavigationAppearance(topicNavigationController)
        configureNavigationAppearance(shortsNavigationController)
        configureNavigationAppearance(searchNavigationController)
        setViewControllers(
            [topicNavigationController, shortsNavigationController, searchNavigationController],
            animated: true
        )
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = .lightGray
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = .black
    }
    
    private func configureNavigationAppearance(_ navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.tintColor = .black
    }
}
